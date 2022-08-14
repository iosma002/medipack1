
 
import Foundation
import FirebaseFirestore
import FirebaseStorageCombineSwift
import Combine

class MedicineViewModel: ObservableObject {
    

   
  @Published var medicine: Medicine
  @Published var modified = false
   
   private var cancellables = Set<AnyCancellable>()
    
   init(medicine: Medicine = Medicine(title: "", description: "", year: "")) {
    self.medicine = medicine
     
    self.$medicine
      .dropFirst()
      .sink { [weak self] medicine in
        self?.modified = true
      }
      .store(in: &self.cancellables)
  }
    
  
     
   
   
  // Firestore call
   
  private var db = Firestore.firestore()
   
  private func addMedicine(_ medicine: Medicine) {
    do {
      let _ = try db.collection("medicinelist").addDocument(from: medicine)
    }
    catch {
      print(error)
    }
  }
   
  private func updateMedicine(_ medicine: Medicine) {
    if let documentId = medicine.id {
      do {
        try db.collection("medicinelist").document(documentId).setData(from: medicine)
      }
      catch {
        print(error)
      }
    }
  }
   
  private func updateOrAddMedicine() {
    if let _ = medicine.id {
      self.updateMedicine(self.medicine)
    }
    else {
      addMedicine(medicine)
    }
  }
   
  private func removeMedicine() {
    if let documentId = medicine.id {
      db.collection("medicinelist").document(documentId).delete { error in
        if let error = error {
          print(error.localizedDescription)
        }
      }
    }
  }
    

  // UI handlers
   
  func handleDoneTapped() {
    self.updateOrAddMedicine()
  }
   
  func handleDeleteTapped() {
    self.removeMedicine()
  }
   
}

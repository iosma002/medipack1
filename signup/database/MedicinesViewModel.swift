
import Foundation
import Combine
import FirebaseFirestore
 
class MedicinesViewModel: ObservableObject {
  @Published var medicines = [Medicine]()
   
  private var db = Firestore.firestore()
  private var listenerRegistration: ListenerRegistration?
   
  deinit {
    unsubscribe()
  }
   
  func unsubscribe() {
    if listenerRegistration != nil {
      listenerRegistration?.remove()
      listenerRegistration = nil
    }
  }
   
  func subscribe() {
    if listenerRegistration == nil {
      listenerRegistration = db.collection("medicinelist").addSnapshotListener { (querySnapshot, error) in
        guard let documents = querySnapshot?.documents else {
          print("No documents")
          return
        }
         
        self.medicines = documents.compactMap { queryDocumentSnapshot in
          try? queryDocumentSnapshot.data(as: Medicine.self)
        }
      }
    }
  }
   
  func removeMedicines(atOffsets indexSet: IndexSet) {
    let medicines = indexSet.lazy.map { self.medicines[$0] }
    medicines.forEach { medicine in
      if let documentId = medicine.id {
        db.collection("medicinelist").document(documentId).delete { error in
          if let error = error {
            print("Unable to remove document: \(error.localizedDescription)")
          }
        }
      }
    }
  }
 
   
}

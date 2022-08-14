
 
import SwiftUI
 
struct MedicineDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditMedicineSheet = false
     
    var medicine: Medicine
     
    private func editButton(action: @escaping () -> Void) -> some View {
      Button(action: { action() }) {
        Text("Edit")
      }
    }
     
    var body: some View {
      Form {
        Section(header: Text("MEDICATION DATABASE")) {
          Text(medicine.title)
          Text(medicine.description)
             
        }
         
        Section(header: Text("Year")) {
            Text(medicine.year)
        }
      }
      .navigationBarTitle(medicine.title)
      .navigationBarItems(trailing: editButton {
        self.presentEditMedicineSheet.toggle()
      })
      .onAppear() {
        print("MedicineDetailsView.onAppear() for \(self.medicine.title)")
      }
      .onDisappear() {
        print("MedicineDetailsView.onDisappear()")
      }
      .sheet(isPresented: self.$presentEditMedicineSheet) {
        MedicineEditView(viewModel: MedicineViewModel(medicine: medicine), mode: .edit) { result in
          if case .success(let action) = result, action == .delete {
            self.presentationMode.wrappedValue.dismiss()
          }
        }
      }
    }
     
  }
 
struct MedicineDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let medicine = Medicine(title: "title medication", description: "this is a sample description", year: "2021")
        return
          NavigationView {
            MedicineDetailsView(medicine: medicine)
          }
    }
}

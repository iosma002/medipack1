
 
import SwiftUI
 
enum Mode {
  case new
  case edit
}
 
enum Action {
  case delete
  case done
  case cancel
}
 
struct MedicineEditView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
     
    @ObservedObject var viewModel = MedicineViewModel()
    var mode: Mode = .new
    var completionHandler: ((Result<Action, Error>) -> Void)?
     
     
    var cancelButton: some View {
      Button(action: { self.handleCancelTapped() }) {
        Text("Cancel")
      }
    }
     
    var saveButton: some View {
      Button(action: { self.handleDoneTapped() }) {
        Text(mode == .new ? "Done" : "Save")
      }
      .disabled(!viewModel.modified)
    }
     
    var body: some View {
      NavigationView {
        Form {
          Section(header: Text("Medicine")) {
            TextField("Title", text: $viewModel.medicine.title)
            TextField("Year", text: $viewModel.medicine.year)
          }
           
          Section(header: Text("Description")) {
            TextField("Description", text: $viewModel.medicine.description)
          }
           
          if mode == .edit {
            Section {
              Button("Delete Medicine") { self.presentActionSheet.toggle() }
                .foregroundColor(.red)
            }
          }
        }
        .navigationTitle(mode == .new ? "Add Medication information" : viewModel.medicine.title)
        .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
        .navigationBarItems(
          leading: cancelButton,
          trailing: saveButton
        )
        .actionSheet(isPresented: $presentActionSheet) {
          ActionSheet(title: Text("Are you sure?"),
                      buttons: [
                        .destructive(Text("Delete Medicine"),
                                     action: { self.handleDeleteTapped() }),
                        .cancel()
                      ])
        }
      }
    }
     
    // Action Handlers
     
    func handleCancelTapped() {
      self.dismiss()
    }
     
    func handleDoneTapped() {
      self.viewModel.handleDoneTapped()
      self.dismiss()
    }
     
    func handleDeleteTapped() {
      viewModel.handleDeleteTapped()
      self.dismiss()
      self.completionHandler?(.success(.delete))
    }
     
    func dismiss() {
      self.presentationMode.wrappedValue.dismiss()
    }
  }
 
//struct MedicineEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        MedicineEditView()
//    }
//}
 
struct MedicineEditView_Previews: PreviewProvider {
  static var previews: some View {
    let medicine = Medicine(title: "Sample title", description: "Sample Description", year: "2020")
    let medicineViewModel = MedicineViewModel(medicine: medicine)
    return MedicineEditView(viewModel: medicineViewModel, mode: .edit)
  }
}

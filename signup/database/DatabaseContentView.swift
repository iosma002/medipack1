
import SwiftUI


 
struct DatabaseContentView: View {
     
    @StateObject var viewModel = MedicinesViewModel() //MedicineViewModel.swift
    @State var presentAddMedicineSheet = false

    
    
     
    private var addButton: some View {
      Button(action: { self.presentAddMedicineSheet.toggle() }) {
        Image(systemName: "plus")
      }
    }
    
     
    private func medicineRowView(medicine: Medicine) -> some View {
       NavigationLink(destination: MedicineDetailsView(medicine: medicine)) { //MedicineDetailsView.swift
         VStack(alignment: .leading) {
           Text(medicine.title)
             .font(.headline)
           //Text(medicine.description)
           //  .font(.subheadline)
            Text(medicine.year)
             .font(.subheadline)
         }
       }
    }
     
    var body: some View {
      NavigationView {
        List {
          ForEach (viewModel.medicines) { medicine in
            medicineRowView(medicine: medicine)
          }
          .onDelete() { indexSet in
            //viewModel.removeMedicines(atOffsets: indexSet)
            viewModel.removeMedicines(atOffsets: indexSet)
          }
        }
        .navigationBarTitle("Medication Data")
        .navigationBarItems(trailing: addButton)
        .onAppear() {
          print("MedicinesListView appears. Subscribing to data updates.")
          self.viewModel.subscribe()
        }
        .sheet(isPresented: self.$presentAddMedicineSheet) {
          MedicineEditView() //MedicineEditView.swift
        }
         
      }// End Navigation
    }// End Body
}





 


struct DatabaseContentView_Previews: PreviewProvider {
    static var previews: some View {
        DatabaseContentView()
    }
}



import SwiftUI
import SDWebImageSwiftUI
import Firebase
 
struct Home: View {
    
    //SwiftUI manages the storage of a property that you declare as state. When the value changes, SwiftUI updates the parts of the view hierarchy that depend on the value.
    @State var shouldShowLogOutOptions = false
     
    //The ObservableObject conformance allows instances of this class to be used inside views, so that when important changes happen the view will reload (this ensures that the current user logged is visible on the profile bar.
    @ObservedObject private var vm = MainMessagesViewModel()
    
     //A binding in SwiftUI is a connection between a value and a view that displays and changes it. You can create your own bindings with the @Binding property wrapper, and pass bindings into views that require them.
    @Binding var isUserCurrentlyLoggedOut : Bool
     
    @State var index = 0
     
    var body: some View {
        //contents of the HomeView
        VStack {
            //integrates the navigation bar with information onto the home page
            Text("Welcome: \(vm.chatUser?.uid ?? "")").foregroundColor(.white)
            customNavBar
 
            ZStack {
                //links from the dashboard to the daily medicine dashboard
                if self.index == 0 {
                    Text("")
                    NavigationLink(destination: TodoView()) {
                        Text("Add Medication")
                            .frame(width: 200, height: 200)
                        
                    }
                }
                
                else if self.index == 1 {
                    Text("")
                    NavigationLink(destination: DatabaseContentView()) {
                        Text("Search Medication")
                            .frame(width: 200, height: 200)
                    }
                }
             
               
            }
                  
            CustomTabBar(index: $index)
        }
        .navigationBarHidden(true)

    }
     //custom navigationbar alignment
    private var customNavBar: some View {
        HStack(spacing: 20) {
           
 // get web image from the server to appear
            WebImage(url: URL(string: vm.chatUser?.profileImageUrl ?? ""))
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipped()
                .cornerRadius(50)
                .overlay(RoundedRectangle(cornerRadius: 44)
                            .stroke(Color(.label), lineWidth: 1)
                )
                .shadow(radius: 5)
             //get username of currently logged in to show
            VStack(alignment: .leading, spacing: 4) {
                let email = vm.chatUser?.email.replacingOccurrences(of: "@gmail.com", with: "") ?? ""
                Text(email)
                    .font(.system(size: 24, weight: .bold))
                 // allow users to be online
                HStack {
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 14, height: 14)
                    Text("online")
                        .font(.system(size: 12))
                        .foregroundColor(Color(.lightGray))
                }
                 
            }
             //logout button
            Spacer()
            Button {
                shouldShowLogOutOptions.toggle()
            } label: {
                Image(systemName: "gear")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color(.label))
            }
        }
        //logout button query
        .padding()
        .actionSheet(isPresented: $shouldShowLogOutOptions) {
            .init(title: Text("Settings"), message: Text("What do you want to do?"), buttons: [
                .destructive(Text("Sign Out"), action: {
                    print("handle sign out")
                    try? Auth.auth().signOut()
                    self.isUserCurrentlyLoggedOut = false
                }),
                    .cancel()
            ])
        }
    }
}
 
struct Home_Previews: PreviewProvider {
    @State static var isUserCurrentlyLoggedOut = false
    static var previews: some View {
        Home(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut)
    }
}


  
import SwiftUI
import Firebase
import UserNotifications



  
@main
struct signup: App {
      
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
       
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
//allows local notifications
class AppDelegate: NSObject,UIApplicationDelegate, UNUserNotificationCenterDelegate{
    
    let notificationCenter = UNUserNotificationCenter.current()

    
       
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        requestAuthForLocalNotifications()
        
           
        FirebaseApp.configure()
        return true
    }


func requestAuthForLocalNotifications(){
       notificationCenter.delegate = self
       let options: UNAuthorizationOptions = [.alert, .sound, .badge]
       notificationCenter.requestAuthorization(options: options) { (didAllow, error) in
           if !didAllow {
               print("User has declined notification")
           }
       }
   }
}


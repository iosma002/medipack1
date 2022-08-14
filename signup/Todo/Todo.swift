
import Foundation
import FirebaseFirestoreSwift
import FirebaseAuth
 
struct Todo: Identifiable, Codable {
  @DocumentID var id: String?
  var todo: String
  var desc: String
  var weeks: String

    
   
  enum CodingKeys: String, CodingKey {
    case id
    case todo
    case desc
    case weeks
  }
}

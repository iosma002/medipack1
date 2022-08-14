

import Foundation
import Foundation
import FirebaseFirestoreSwift
import FirebaseAuth
 
struct Medicine: Identifiable, Codable {
  @DocumentID var id: String?
  var title: String
  var description: String
  var year: String
    
   
  enum CodingKeys: String, CodingKey {
    case id
    case title
    case description
    case year
  }
}

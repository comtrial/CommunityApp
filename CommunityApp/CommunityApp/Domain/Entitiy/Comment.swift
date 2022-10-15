import Foundation

struct Comment : Codable {
    var comment : String
    var author : String
    var datetime : String
    var image : String?
}

struct CommentService : Codable {
    var success : Bool
    var status : String
    var contents : [Comment]

}


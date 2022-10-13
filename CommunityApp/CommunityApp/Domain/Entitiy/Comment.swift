import Foundation

struct Comment : Codable {
    var comment : String
    var author : String
    var writtenAt : String
    var image : String?
    var id : Int
}

struct CommentService : Codable {
    var success : Bool
    var status : Int
    var contents : [Comment]

}


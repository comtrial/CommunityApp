import Foundation

struct ArticleDetailService : Codable {
    var success : Bool
    var status : Int
    var post : String
    var author : String
    var commentsNum : Int
    var writtenAt : String
    var tag : String
    var images : [String]?
    var id : Int

}

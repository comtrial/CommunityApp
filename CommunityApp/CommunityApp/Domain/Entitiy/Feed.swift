import Foundation

struct Feed : Codable {
    var thumbnailPost : String
    var author : String
    var commentsNum : Int
    var writtenAt : String
    var tag : String
    var thumbnailImages : [String]
    var moreButton : Bool
    var id : Int
    
}


struct Pagination : Codable {
    var currentPage : Int
    var totalPage : Int
    var perPage : Int
    var totalPost : Int
}

struct FeedService : Codable {
    var success : Bool
    var status : String
    var pagination : Pagination
    var contents : [Feed]
}


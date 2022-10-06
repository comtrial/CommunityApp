import Foundation

struct Contents : Codable {
    var thumbailPost : String
    var author : String
    var commentsNum : Int
    var writtenAt : String
    var tag : String
    var thumbnailimages : [String]? // "thumbnailimages" 안에 nil 값이 있기 때문에 optional 처리 해줌
    var moreButton : Bool
    var id : Int
}

struct HomepagePagination : Codable {
    var currentPage : Int
    var totalPage : Int
    var perPage : Int
    var totalPost : Int
}

struct HomepageService : Codable {
    var success : Bool
    var status : Int
    var pagination : HomepagePagination
    var contents : [Contents]

}

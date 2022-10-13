import Foundation

struct Feed : Codable {// 피드에 있는 게시물
    var thumbailPost : String
    var author : String
    var commentsNum : Int
    var writtenAt : String
    var tag : String
    var thumbnailimages : [String]? // "thumbnailimages" 안에 nil 값이 있기 때문에 optional 처리 해줌
    var moreButton : Bool
    var id : Int
    
//    enum CodingKeys : String, CodingKey {
//        case thumbailPost, author, commentsNum, writtenAt, thumbnailimages, moreButton, id
//         case type = "tag"
//    }
}


struct Pagination : Codable {
    var currentPage : Int
    var totalPage : Int
    var perPage : Int
    var totalPost : Int
}

struct FeedService : Codable {
    var success : Bool
    var status : Int
    var pagination : Pagination
    var contents : [Feed]
}

//Feed 정의 : 사람들이 사진과 동영상을 공유하고, 커뮤니티와 소통하고, 관심 있는 콘텐츠를 둘러볼 수 있는 모바일에 최적화된 랜딩 페이지!

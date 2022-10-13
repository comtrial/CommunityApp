import Foundation
import Combine

class CommentRepository {
    let detailFeedIdx: Int
    
    init(detailFeedIdx: Int) {
        self.detailFeedIdx = detailFeedIdx
    }
    
    
    func fetchCommentPublisher() -> AnyPublisher<CommentService, Error> {
//        let urlString = "https://38c0eb6a-ec24-4aa3-8eaf-db9ab721a74a.mock.pstmn.io/api/v1/comment/\(detailFeedIdx)"
        let urlString = "https://38c0eb6a-ec24-4aa3-8eaf-db9ab721a74a.mock.pstmn.io/api/v1/comment/1"
        
        let url = URL(string: urlString)!
        print(urlString)
        return URLSession.shared.dataTaskPublisher(for: url).map { $0.data }
            .decode(type: CommentService.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

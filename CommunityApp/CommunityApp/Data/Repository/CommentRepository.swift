import Foundation
import Combine

class CommentRepository {
    let detailFeedIdx: Int
    
    init(detailFeedIdx: Int) {
        self.detailFeedIdx = detailFeedIdx
    }
    
    
    func fetchCommentPublisher() -> AnyPublisher<CommentService, Error> {
        let urlString = "https://9qedenmbo3.execute-api.ap-northeast-2.amazonaws.com/api/v1/comment/\(detailFeedIdx)"
        
        let url = URL(string: urlString)!
        print(urlString)
        return URLSession.shared.dataTaskPublisher(for: url).map { $0.data }
            .decode(type: CommentService.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

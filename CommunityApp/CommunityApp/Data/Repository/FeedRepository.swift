import Foundation
import Combine

class FeedsRepository {


    func fetchFeedsPublisher() -> AnyPublisher<FeedService, Error> {
        let urlString = "https://9qedenmbo3.execute-api.ap-northeast-2.amazonaws.com/api/v1/home?page=1"
        
        let url = URL(string: urlString)!
        
        return URLSession.shared.dataTaskPublisher(for: url).map { $0.data }
            .decode(type: FeedService.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}



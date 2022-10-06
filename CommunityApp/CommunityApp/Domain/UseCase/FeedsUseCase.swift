import Combine

class FeedsUseCase {
    private let feedsRespository: FeedsRepository
    
    init(feedsRespository: FeedsRepository) {
        self.feedsRespository = feedsRespository
    }
    
    func fetchFeedsPublisher(page: Int) -> AnyPublisher<FeedService, Error> {// Publisher
        return feedsRespository.fetchFeedsPublisher()
    }
}

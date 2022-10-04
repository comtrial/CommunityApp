import Combine

class FeedsUseCase {
    private let feedsRespository: FeedsRepository
    
    init(feedsRespository: FeedsRepository) {
        self.feedsRespository = feedsRespository
    }
    
    func fetchFeedsPublisher(page: Int) -> AnyPublisher<FeedsResult, Error> {
        return feedsRespository.fetchFeedsPublisher()
    }
}

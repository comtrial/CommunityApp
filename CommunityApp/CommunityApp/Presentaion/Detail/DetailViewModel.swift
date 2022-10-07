
import Combine

class DetailViewModel {
    let repository: DetailFeedRepository
    var subscriber: Set<AnyCancellable> = .init()
    
    @Published var DetailFeedService: DetailFeedService?
    
    init(repository: DetailFeedRepository) {
        self.repository = repository
    }
    
    func fetchDetailFeedService() {
        repository.fetchDetailFeedPublisher().sink { completion in
            switch completion {
            case .failure(let err):
                print("err: \(err)")
            case .finished: break
            }
        } receiveValue: { DetailFeedService in
            print(DetailFeedService)
        }.store(in: &subscriber)
    }
}

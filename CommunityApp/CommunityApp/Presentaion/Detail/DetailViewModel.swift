
import Combine

class DetailViewModel {
    
    let repository: DetailFeedRepository
    
    @Published var DetailFeedService: DetailFeedService?
    
    init(repository: DetailFeedRepository) {
        self.repository = repository
    }
    
    func fetchDetailFeedService(detailFeedIdx: Int) {
        repository.fetchDetailFeedPublisher(detailFeedIdx: detailFeedIdx).sink { completion in
            switch completion {
            case .failure(let err):
                print("err: \(err)")
            case .finished: break
            }
        } receiveValue: { DetailFeedService in
            print(DetailFeedService)
        }
    }
    
    
}

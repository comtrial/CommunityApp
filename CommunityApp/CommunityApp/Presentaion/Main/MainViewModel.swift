
import Foundation
import Combine

class MainViewModel {
    let usecase: FeedsUseCase
    
    @Published var feeds: [FeedService]?
    @Published var errMessage: String?
    
    var subscriber: Set<AnyCancellable> = .init()
    
    
    init(usecase: FeedsUseCase) {
        self.usecase = usecase
    }
    
    func load(page: Int) {
//        usecase.fetchFeedsPublisher(page: page) { result in
//            switch result {
//            case .success:
//                print("success...")
//            case .failure:
//                print("fail...")
//            }
//        }
        usecase.fetchFeedsPublisher(page: 1).sink{ completion in
            switch completion {
            case .failure(let error):
                print("err: \(error)")
            case .finished: break
            }
        } receiveValue: { FeedService in
            print(FeedService)
        }.store(in: &subscriber)
    }
}


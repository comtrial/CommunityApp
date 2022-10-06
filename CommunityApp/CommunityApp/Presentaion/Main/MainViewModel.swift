
import Foundation
import Combine

class MainViewModel {
    let usecase: FeedsUseCase
    
    @Published var feeds: [Feed]?
    @Published var errMessage: String?
    
    init(usecase: FeedsUseCase) {
        self.usecase = usecase
    }
    
    private func load(page: Int) {
        usecase.fetchFeedsPublisher(page: page) { result in
            switch result {
            case .success:
                print("success...")
            case .failure:
                print("fail...")
            }
        }
    }
}


import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    
    // TODO: resolve dependency problem
    func start() {
        
        let repository = FeedsRepository()
        let usecase = FeedsUseCase(feedsRespository: repository)
        let viewModel = MainViewModel(usecase: usecase)
        let rootViewController = MainViewController(viewModel: viewModel)

        // let rootViewController = MainViewController()
        rootViewController.coordinator = self
        navigationController?.setViewControllers([rootViewController], animated: true)
    }
    
    func pushToDetail(detailFeedIdx: Int) {
        let repository = DetailFeedRepository(detailFeedIdx: detailFeedIdx)
        let viewModel = DetailViewModel(repository: repository)
        let vc = DetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}


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
        navigationController?.setViewControllers([rootViewController], animated: true)
    }
}


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
        //  rootViewController.coordinator = self
        navigationController?.setViewControllers([rootViewController], animated: true)
    }
    
    func pushToDetail(detailFeedIdx: Int) {
        let detailFeedRepository = DetailFeedRepository(detailFeedIdx: detailFeedIdx)
        let commentsRepository = CommentRepository(detailFeedIdx: detailFeedIdx)
        let viewModel = DetailViewModel(detailFeedrepository: detailFeedRepository, commentsRepository: commentsRepository)
        let vc = DetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}

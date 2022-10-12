
import Combine

class DetailViewModel {
    let detailFeedrepository: DetailFeedRepository
    let commentsRepository: CommentRepository
    
    var subscriber: Set<AnyCancellable> = .init()
    
    @Published var DetailFeedService: DetailFeedService?
    @Published var comments: [Comment] = []
    @Published var loading = true
    
    init(detailFeedrepository: DetailFeedRepository, commentsRepository: CommentRepository) {
        self.detailFeedrepository = detailFeedrepository
        self.commentsRepository = commentsRepository
    }
    
    func fetchDetailFeedService() {
        detailFeedrepository.fetchDetailFeedPublisher().sink { completion in
            switch completion {
            case .failure(let err):
                print("err: \(err)")
            case .finished: break
            }
        } receiveValue: { DetailFeedService in
            print(DetailFeedService)
            self.DetailFeedService = DetailFeedService
            self.loading = false
        }.store(in: &subscriber)
    }
    
    func fetchComments() {
        commentsRepository.fetchCommentPublisher().sink { completion in
            switch completion {
            case .failure(let err):
                print("err: \(err)")
            case .finished: break
            }
        } receiveValue: { CommentService in
            print(CommentService)
            self.comments = CommentService.contents
            self.loading = false
        }.store(in: &subscriber)
    }
    
    func createComment(comment: String) {
        let newComment = Comment(comment: comment,
                             author: "me",
                             writtenAt: "방금전",
                             image: nil,
                             id: 66)
        
        self.comments.append(newComment)
        
        
    }
}

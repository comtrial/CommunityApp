import UIKit
import Combine

class DetailViewController: UIViewController {
    let viewModel: DetailViewModel
    var subscriber: Set<AnyCancellable> = .init()
    
    let commentsView = CommentListView()
    let sendTextView = SendTextView()
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupKeyboardHiding()
        viewModel.fetchDetailFeedService()
        viewModel.fetchComments()
        configureUI()
    }
    
    let loadingView = LoadingView()
    
    func configureUI() {
        view.backgroundColor = .white
        
        let detailContentView = DetailContentView(frame: .zero, detailFeedService: viewModel.DetailFeedService)
        
        // MARK: ContentView
        view.addSubview(detailContentView)
        detailContentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailContentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            detailContentView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 14),
            detailContentView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 14),
            detailContentView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        // MARK: CommentsView
        view.addSubview(commentsView)
        commentsView.translatesAutoresizingMaskIntoConstraints = false
        commentsView.tableView.delegate = self
        commentsView.tableView.dataSource = self
        NSLayoutConstraint.activate([
            commentsView.topAnchor.constraint(equalTo: detailContentView.bottomAnchor),
            commentsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            commentsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            commentsView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        
        ])
        
        // MARK: SendTextView
        view.addSubview(sendTextView)
        sendTextView.translatesAutoresizingMaskIntoConstraints = false
        sendTextView.textView.delegate = self
        
        NSLayoutConstraint.activate([
            sendTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            sendTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sendTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sendTextView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        // MARK: LoadingView
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    func bind() {
        viewModel.$loading.sink { loading in
            self.loadingView.isHidden = !loading
            self.configureUI()
            self.commentsView.tableView.reloadData()
            print(loading)
        }.store(in: &subscriber)
    }
}

// MARK: sendTextView Placeholder
extension DetailViewController: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == sendTextView.typingPlaceholder {
            textView.text = nil
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = sendTextView.typingPlaceholder
            textView.textColor = .gray
        }
    }
}

// MARK: slide up SendTextView when keyboar show
extension DetailViewController {
    @objc func keyboardWillHide(notification: NSNotification) {
        print("hide")
        let sendTextViewHeight = self.sendTextView.frame.height
        self.sendTextView.frame.origin.y = view.frame.height - sendTextViewHeight
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextView else { return }
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        if textFieldBottomY > keyboardTopY {
            let sendTextViewHeight = self.sendTextView.frame.height
            let newFrameY = (keyboardTopY - sendTextViewHeight + 36)
            self.sendTextView.frame.origin.y = newFrameY
        }
        
        print("called")
        
    }
    func setupKeyboardHiding() {
        print("keyboard setup done")
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

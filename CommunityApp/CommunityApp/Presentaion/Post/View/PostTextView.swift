import UIKit

class PostTextView : UIView {

    //let placeHolder = "우리 동네 관련된 질문이나 이야기를 해보세요."
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    let textView: UITextView = {
        let view = UITextView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .purple
        configureUI()
    }
    
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    func configureUI() {
        self.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(textView)
    
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        scrollView.topAnchor.constraint(equalTo: self.topAnchor),
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        
        
        containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
        containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
        containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
        
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        containerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
//        let heightAnchor = containerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
//        heightAnchor.priority = .defaultHigh
//        heightAnchor.isActive = true
        
        
        textView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
        textView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
        textView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
        textView.heightAnchor.constraint(equalToConstant: 520)
        ])
        //textView.text = placeHolder
        textView.backgroundColor = .white
        addKeyboardObserver()
    }
    
    private func addKeyboardObserver() {
        // Register Keyboard notifications
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
//        guard let userInfo = notification.userInfo,
//            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
//                return
//        }
        let textCursor = textView.selectedTextRange
        
        let contentInset = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: 0.0,//keyboardFrame.size.height,
            right: 0.0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
        
        let firstResponder = UIResponder.currentFirstResponder
        
        if let textView = firstResponder as? UITextView {
            scrollView.scrollRectToVisible(textView.frame, animated: true)
        }
    }
    
    @objc private func keyboardWillHide() {
        let contentInset = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }
}

import UIKit

class ViewController: UIViewController {

    let postTextView = PostTextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }

    func configureUI () {
        view.addSubview(postTextView)
        postTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            postTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
           
        ])
    }
    
}

import UIKit

class MainViewController: UIViewController {
    private var text: UILabel = UILabel()
    private var button: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        drawText()
        drawBtn()
    }
    
    func drawText() {
        view.addSubview(text)

        // MARK: No StoryBoard setup
        text.translatesAutoresizingMaskIntoConstraints = false

        // MARK: UI Component attribute setup
        text.text = "기본 프로젝트"

        // MARK: UI Component Layout setup
        text.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        text.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    }
    
    func drawBtn() {
        view.addSubview(button)

        button.translatesAutoresizingMaskIntoConstraints = false

        button.setTitle("상세 페이지", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(btnClicked), for: .touchDown)
        
        button.topAnchor.constraint(equalTo: text.bottomAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

    }
    
    @objc func btnClicked() {
        DetailCoordinator(nvc: self.navigationController!).start()
    }

}


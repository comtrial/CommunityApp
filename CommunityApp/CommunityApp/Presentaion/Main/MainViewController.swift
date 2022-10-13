import UIKit
import Combine

class MainViewController: UIViewController {
    let viewModel: MainViewModel
    var subscriber: Set<AnyCancellable> = .init()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 300
        return tableView
    }()

    let loadingView = LoadingView()


// MARK
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.load(page: 1) //MARK 무조건 여기가 문제다 무조건!
        attribute()
        setTable()
        view.backgroundColor = .white
    }

    func attribute() {
        tableView.register(MainViewCell.self, forCellReuseIdentifier: MainViewCell.cellId)
        tableView.delegate = self
        tableView.dataSource = self
    }

    func setTable(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }

    func bind() {
        viewModel.$loading.sink { loading in
            self.loadingView.isHidden = !loading
            self.attribute()
            self.tableView.reloadData()
            print(loading)
        }.store(in: &subscriber)
    }

}



extension MainViewController:  UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel.feeds.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainViewCell.cellId, for: indexPath) as! MainViewCell


//        cell.thumbnailImage.image = viewModel.feeds![indexPath.row].thumbnailimages.map{ $0 }  //MARK
        cell.author.text = viewModel.feeds[indexPath.row].author
        cell.commentsNum.text = "댓글 : \(viewModel.feeds[indexPath.row].commentsNum)"
        cell.writtenAt.text = viewModel.feeds[indexPath.row].writtenAt
        cell.taglabel.text = viewModel.feeds[indexPath.row].tag
        cell.thumbnailPost.text = viewModel.feeds[indexPath.row].thumbailPost

        return cell
    }
}






//import UIKit
//
//class MainViewController: UIViewController {
//    let viewModel: MainViewModel
//    var coordinator: MainCoordinator?
//
//    private var text: UILabel = UILabel()
//    private var button: UIButton = UIButton()
//
//    init(viewModel: MainViewModel) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        viewModel.load(page: 1)
//        configureUI()
//    }
//
//
//    func configureUI() {
//        view.backgroundColor = .white
//        drawText()
//        drawBtn()
//    }
//
//    func drawText() {
//        view.addSubview(text)
//
//        // MARK: No StoryBoard setup
//        text.translatesAutoresizingMaskIntoConstraints = false
//
//        // MARK: UI Component attribute setup
//        text.text = "기본 프로젝트"
//
//        // MARK: UI Component Layout setup
//        text.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        text.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//
//    }
//
//    func drawBtn() {
//        view.addSubview(button)
//
//        button.translatesAutoresizingMaskIntoConstraints = false
//
//        button.setTitle("상세 페이지", for: .normal)
//        button.setTitleColor(.blue, for: .normal)
//        button.addTarget(self, action: #selector(btnClicked), for: .touchDown)
//
//        button.topAnchor.constraint(equalTo: text.bottomAnchor).isActive = true
//        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//
//    }
//
//    @objc func btnClicked() {
//        coordinator?.pushToDetail(detailFeedIdx: 1)
////        DetailCoordinator(nvc: self.navigationController!).start()
//    }
//
//}
//

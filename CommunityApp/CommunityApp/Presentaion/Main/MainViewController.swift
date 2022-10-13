import UIKit
import Combine

class MainViewController: UIViewController {
    var coordinator: MainCoordinator?
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



extension MainViewController:  UITableViewDataSource {
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

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item =   viewModel.feeds[indexPath.row]
        coordinator?.pushToDetail(detailFeedIdx: viewModel.feeds[indexPath.row].id)
    }
}







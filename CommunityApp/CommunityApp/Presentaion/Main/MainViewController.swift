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
    let writeButton: UIButton = {
        let writeButton = UIButton()
        writeButton.layer.masksToBounds = true // true로 주면 버튼 안에 내용이 짤려서 보이게 할 수 있음
        writeButton.layer.cornerRadius = 25
        writeButton.backgroundColor = .systemOrange

        let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        writeButton.setImage(image, for: .normal)
        writeButton.tintColor = .white
        writeButton.addTarget(self, action: #selector(btnClicked), for: .touchDown)
                             
        return writeButton
    }()


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
        viewModel.load(page: 1)
        attribute()
        configureUI()
        view.backgroundColor = .white
    }
    


    func attribute() {
        tableView.register(MainViewCell.self, forCellReuseIdentifier: MainViewCell.cellId)
        tableView.delegate = self
        tableView.dataSource = self
    }

    func configureUI(){
        let safeArea = view.safeAreaLayoutGuide
        
        // MARK: TableViiew
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        //MARK: writebutton / floatingbutton
        view.addSubview(writeButton)
        writeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        writeButton.heightAnchor.constraint(equalToConstant: 50),
        writeButton.widthAnchor.constraint(equalToConstant: 50),
        writeButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
        writeButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10)
        
        ])
    }
    
    @objc func btnClicked() {
        coordinator?.pushToPost()
    }
    
    
    //MARK: Binding
    func bind() {
        viewModel.$loading.sink { loading in
            self.loadingView.isHidden = !loading
            self.attribute()
            self.tableView.reloadData()
            print(loading)
        }.store(in: &subscriber)
    }

}


// MARK: tableView DataProcess
extension MainViewController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel.feeds.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainViewCell.cellId, for: indexPath) as! MainViewCell
        
        /* if thumbnailimages.count == 0 {
            
              } else {
                cell.thumbnailimages
            }
    */
    
//        cell.thumbnailImage.image = viewModel.feeds![indexPath.row].thumbnailimages.map{ $0 } 
        cell.author.text = viewModel.feeds[indexPath.row].author
        cell.commentsNum.text = "댓글 : \(viewModel.feeds[indexPath.row].commentsNum)"
        cell.writtenAt.text = viewModel.feeds[indexPath.row].writtenAt
        cell.taglabel.text = viewModel.feeds[indexPath.row].tag
        cell.thumbnailPost.text = viewModel.feeds[indexPath.row].thumbnailPost

        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.feeds[indexPath.row]
        coordinator?.pushToDetail(detailFeedIdx: viewModel.feeds[indexPath.row].id)
    }
}







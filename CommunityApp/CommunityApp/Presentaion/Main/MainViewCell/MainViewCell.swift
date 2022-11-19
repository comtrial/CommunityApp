import UIKit

class MainViewCell: UITableViewCell, UITableViewDelegate {

    static let cellId = "CellId"
    lazy var thumbnailPost : UILabel = {
        let thumbnailPost = UILabel()
        thumbnailPost.font = UIFont.boldSystemFont(ofSize: 16)
        thumbnailPost.numberOfLines = 3
        return thumbnailPost
    }()
    lazy var author = UILabel()
    lazy var commentsNum = UILabel()
    lazy var writtenAt : UILabel = {
        let writtenAt = UILabel()
        writtenAt.font = UIFont.boldSystemFont(ofSize: 12)
        return writtenAt
    }()
    lazy var taglabel : UILabel = {
        let taglabel = UILabel()
        taglabel.backgroundColor = UIColor.lightGray
        taglabel.font = UIFont.boldSystemFont(ofSize: 12)
        
        return taglabel
    }()
    lazy var imageCollectionView : UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: imageCollectionViewFlowLayout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.contentInset = .zero
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view

    }()
    
    private let imageCollectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    
    func conf(with data: [String]) {
        for imageString in data {
            let image = UIImage(named: imageString)!
            self.data.append(image)
        }
    }
    var data = [UIImage]()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        setupImageCollectionView()
        configureCollectionView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
    
    func configureUI() {
            self.addSubview(author)
            self.addSubview(thumbnailPost)
            self.addSubview(taglabel)
            self.addSubview(commentsNum)
            self.addSubview(writtenAt)
            
        thumbnailPost.translatesAutoresizingMaskIntoConstraints = false
        author.translatesAutoresizingMaskIntoConstraints = false
        taglabel.translatesAutoresizingMaskIntoConstraints = false
        commentsNum.translatesAutoresizingMaskIntoConstraints = false
        writtenAt.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
           
            taglabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            taglabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            thumbnailPost.topAnchor.constraint(equalTo: taglabel.bottomAnchor, constant: 15),
            thumbnailPost.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            thumbnailPost.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
                        
            commentsNum.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            commentsNum.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            
            author.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            author.bottomAnchor.constraint(equalTo: commentsNum.topAnchor, constant: -15),
            
            writtenAt.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            writtenAt.bottomAnchor.constraint(equalTo: commentsNum.topAnchor, constant: -15)
        ])
        
        commentsNum.sizeToFit()
        author.sizeToFit()
        writtenAt.sizeToFit()
        thumbnailPost.sizeToFit()
        taglabel.sizeToFit()
            
        }
    
    //MARK: CollectionView
    func configureCollectionView() {
        
        imageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        imageCollectionView.backgroundColor = .gray
        self.contentView.addSubview(imageCollectionView)
        
        imageCollectionView.topAnchor.constraint(equalTo: thumbnailPost.bottomAnchor, constant: 20).isActive = true
        imageCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageCollectionView.bottomAnchor.constraint(equalTo: author.topAnchor, constant: -20).isActive = true
        imageCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    func setupImageCollectionView() {
        imageCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "cellIdentifier")
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.isPagingEnabled = true
        imageCollectionView.showsHorizontalScrollIndicator = false
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()

            contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0))
        }
}

extension MainViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return imageCollectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! ImageCollectionViewCell
        cell.imageView.image = data[indexPath.row]
        return cell
    }
}

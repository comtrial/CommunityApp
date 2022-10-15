
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
        taglabel.backgroundColor = UIColor.gray
        taglabel.font = UIFont.boldSystemFont(ofSize: 12)
        
        return taglabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
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
    
        
    override func layoutSubviews() {
            super.layoutSubviews()

            contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0))
        }
}

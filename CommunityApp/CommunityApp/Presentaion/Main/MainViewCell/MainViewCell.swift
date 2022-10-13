
import UIKit

class MainViewCell: UITableViewCell, UITableViewDelegate {

    static let cellId = "CellId"
    

    lazy var thumbnailPost : UILabel = {
       let thumbnailPost = UILabel()
       thumbnailPost.font = UIFont.boldSystemFont(ofSize: 16)
        thumbnailPost.numberOfLines = 3
       return thumbnailPost
    }()  //3줄 넘어서부터는 더보기로 구현
    
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
    
//    let thumbnailImage = UIImageView() //MARK
   // let moreButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
    
    func layout() {
//            self.addSubview(thumbnailImage)
            self.addSubview(author)
            self.addSubview(thumbnailPost)
            self.addSubview(taglabel)
            self.addSubview(commentsNum)
            self.addSubview(writtenAt)
            
        thumbnailPost.translatesAutoresizingMaskIntoConstraints = false
        author.translatesAutoresizingMaskIntoConstraints = false
//        thumbnailImage.translatesAutoresizingMaskIntoConstraints = false
        taglabel.translatesAutoresizingMaskIntoConstraints = false
        commentsNum.translatesAutoresizingMaskIntoConstraints = false
        writtenAt.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // 2
            taglabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            taglabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            thumbnailPost.topAnchor.constraint(equalTo: taglabel.bottomAnchor, constant: 15),
            thumbnailPost.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            thumbnailPost.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
//            thumbnailImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            thumbnailImage.topAnchor.constraint(equalTo: thumbnailPost.bottomAnchor, constant: 20),
//            thumbnailImage.widthAnchor.constraint(equalToConstant: 150),
//            thumbnailImage.heightAnchor.constraint(equalToConstant: 150),
                        
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
    
        
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//        self.backgroundColor = .gray
//        self.contentView.background = .blue
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    override func layoutSubviews() {
            super.layoutSubviews()

            contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0))
        }
}

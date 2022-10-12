
import UIKit

class DetailContentView: UIView {
    let detailFeedService: DetailFeedService?
    
    init(frame: CGRect, detailFeedService: DetailFeedService?) {
        self.detailFeedService = detailFeedService
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        let headerView = drawHeaderView()
        addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.rightAnchor.constraint(equalTo: rightAnchor)
            
        ])
    }
    
    func drawHeaderView() -> UIView {
        let headerView = UIView()
        let tagLabel = UILabel()
        let authorLabel = UILabel()
        let writtenAtLabel = UILabel()
        
        headerView.addSubview(tagLabel)
        tagLabel.text = detailFeedService?.tag
        tagLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        tagLabel.backgroundColor = .systemGray3
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tagLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            tagLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor),
            tagLabel.heightAnchor.constraint(equalToConstant: 22)

        ])
        
        headerView.addSubview(authorLabel)
        authorLabel.text = detailFeedService?.author
        authorLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: tagLabel.bottomAnchor, constant: 12),
            authorLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor)
        ])
        
        headerView.addSubview(writtenAtLabel)
        writtenAtLabel.text = detailFeedService?.writtenAt
        writtenAtLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        writtenAtLabel.textColor = .systemGray
        writtenAtLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            writtenAtLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 8),
            writtenAtLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor)
        ])
        
        return headerView
    }
}

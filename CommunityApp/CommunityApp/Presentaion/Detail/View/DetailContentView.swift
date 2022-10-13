
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
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.rightAnchor.constraint(equalTo: rightAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        let contentView = drawContentView()
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        let footerView = drawFooterView()
        addSubview(footerView)
        footerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            footerView.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8),
//            footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func drawFooterView() -> UIView {
        let footerView = UIView()
        let commentNumLabel = UILabel()
        
        commentNumLabel.text = "댓글 \(detailFeedService?.commentsNum)"
        commentNumLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        footerView.addSubview(commentNumLabel)
        commentNumLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            commentNumLabel.topAnchor.constraint(equalTo: footerView.topAnchor),
//            commentNumLabel.leadingAnchor.constraint(equalTo: footerView.leadingAnchor),
            commentNumLabel.trailingAnchor.constraint(equalTo: footerView.trailingAnchor),
            commentNumLabel.bottomAnchor.constraint(equalTo: footerView.bottomAnchor)
        ])
        
        return footerView
    }
    
    func drawContentView() -> UIView {
        let contentView = UIView()
        let contentTextView = UITextView()
        
        let paraStyle = NSMutableParagraphStyle()
        let fontSize: CGFloat =  16
        let lineHeight = fontSize * 1.6
        
        paraStyle.minimumLineHeight = lineHeight
        paraStyle.maximumLineHeight = lineHeight
        
        contentTextView.attributedText = NSAttributedString(string: detailFeedService?.post ?? "", attributes: [
            .paragraphStyle: paraStyle
        ])
        contentTextView.font = .systemFont(ofSize: fontSize)
        contentTextView.isEditable = false
        
        contentView.addSubview(contentTextView)
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            contentTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        return contentView
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

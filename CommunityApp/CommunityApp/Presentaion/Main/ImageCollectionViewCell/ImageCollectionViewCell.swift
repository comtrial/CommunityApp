import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        self.imageViewSetting()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    
    func imageViewSetting() {
        self.backgroundColor = .green
        self.contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
        imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
        imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
        imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        
        ])
    }

}

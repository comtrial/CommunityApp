//
//  CommentCell.swift
//  CommunityApp
//
//  Created by 최승원 on 2022/10/11.
//

import Foundation
import UIKit

class CommentCell: UITableViewCell {
    
    static let identifier = "CellId"
    
    private var authorTextLabel = UILabel()
    private var commentTextLabel = UILabel()
    private var writtenAtTextLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(item: Comment) {
        self.authorTextLabel.text = item.author
        self.commentTextLabel.text = item.comment
        
        
        self.addSubview(authorTextLabel)
        
        authorTextLabel.translatesAutoresizingMaskIntoConstraints = false
        authorTextLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        authorTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        self.addSubview(commentTextLabel)
        
        commentTextLabel.translatesAutoresizingMaskIntoConstraints = false
        commentTextLabel.topAnchor.constraint(equalTo: authorTextLabel.bottomAnchor, constant: 8).isActive = true
        commentTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        commentTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
    }
}

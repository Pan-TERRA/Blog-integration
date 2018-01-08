//
//  PostCell.swift
//  Blog-integration
//
//  Created by Vlad Krut on 07.01.2018.
//  Copyright © 2018 Vlad Krut. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    // MARK: - Constants
    
    static func height(for post: PostModel) -> CGFloat {
        return 104.0 + (post.text?.textHeightWithFont(font: UIFont.systemFont(ofSize: 16.0), viewWidth: UIWindow.size.width - 88.0, offset: 0) ?? 0)
    }
    
    // MARK: - Properties

    var post: PostModel? { didSet { updateViews() } }
    
    // MARK: - Outlets

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        updateViews()
    }

    private func updateViews() {
        contentLabel?.text = post?.text
        authorLabel?.text = post?.authorName
        
        if let date = post?.date {
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            formatter.dateStyle = .none
            
            dateLabel?.text = "\(date.day) \(date.monthName) \(date.year) \(formatter.string(from: date))"
        }
    }
    
    
}

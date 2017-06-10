//
//  ReceiverCell.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/7/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import UIKit

class ReceiverCell: UITableViewCell, ReusableView, NibLoadableView {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundImageView.backgroundColor = .dbDarkSkyBlue
        timeLabel.textColor = .dbSilver
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        backgroundImageView.roundCorner(corners: [.topLeft,.bottomRight,.bottomLeft], radius: 12)
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        backgroundImageView.roundCorner(corners: [.topLeft,.bottomRight,.bottomLeft], radius: 12)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundImageView.roundCorner(corners: [.topLeft,.bottomRight,.bottomLeft], radius: 12)
    }
}

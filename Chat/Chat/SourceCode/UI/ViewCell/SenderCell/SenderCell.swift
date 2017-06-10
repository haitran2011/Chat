//
//  SenderCell.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/7/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import UIKit
import Kingfisher

class SenderCell: UITableViewCell, ReusableView, NibLoadableView {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var photoImageView: RoundedImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    func updateFromModel(model:Any?) {
        guard  let model = model as? DB2Message else {
            return
        }
        let url = URL(string: model.sender.photo)
        photoImageView.kf.setImage(with: url)
        timeLabel.text = model.createDate.dateFromISO8601?.toString(format: "H:mm")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundImageView.backgroundColor = .white
        messageTextView.textColor = .dbGreyishBrown
        timeLabel.textColor = .dbSilver
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        backgroundImageView.roundCorner(corners: [.topRight,.bottomRight,.bottomLeft], radius: 12)
    }
    
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        backgroundImageView.roundCorner(corners: [.topRight,.bottomRight,.bottomLeft], radius: 12)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundImageView.roundCorner(corners: [.topRight,.bottomRight,.bottomLeft], radius: 12)
    }
}

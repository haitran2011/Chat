//
//  MessageCell.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/6/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import UIKit
import Kingfisher
import SWTableViewCell

class MessageCell: SWTableViewCell, ReusableView, NibLoadableView {

    @IBOutlet weak var profileImageView: RoundedImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var badgeLabel: DB2BadgeView!
    @IBOutlet weak var lastMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configure()
    }
    
    func updateFromModel(model:Any?) {
        guard let model = model as? DB2Channel else { return }
        
        nameLabel.text = "\(model.lastMessage.sender.firstName) \(model.lastMessage.sender.lastName)"
        lastMessageLabel.text = model.lastMessage.text
        let url = URL(string: model.lastMessage.sender.photo)
        profileImageView.kf.setImage(with: url)
        
        if let date = model.lastMessage.createDate.dateFromISO8601 {
            if NSCalendar.current.isDateInToday(date) {
                timeLabel.text = "\(date.toString(format: "H:mm"))"
            } else if NSCalendar.current.isDateInYesterday(date) {
                timeLabel.text = "Yestarday,\(date.toString(format: "H:mm"))"
            } else {
                timeLabel.text = date.toString(format: "dd MMMM, H:mm")
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    func configure() {
        nameLabel.textColor = .dbGreyishBrown
        timeLabel.textColor = .dbSilver
        lastMessageLabel.textColor = .dbDarkSilver
    }
    
    func setBadge(count:Int) {
        if count > 0 {
            badgeLabel.isHidden = false
            badgeLabel.text = "\(count)"
        } else {
            badgeLabel.isHidden = true
        }
    }
}

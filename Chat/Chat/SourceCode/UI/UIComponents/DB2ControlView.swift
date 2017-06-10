//
//  CustomView.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/8/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import UIKit

class DB2ControlView: UIView {
    
    var titleLabel = UILabel()
    var badgeLabel = DB2BadgeView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addCustomView()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addCustomView() {
        self.addSubview(titleLabel)
        self.addSubview(badgeLabel)
        
        self.isUserInteractionEnabled = false
        
        badgeLabel.frame = CGRect.init(x: 0, y: 0, width: 15, height: 15)
        badgeLabel.text = "1"
        badgeLabel.font = .dbTextStyle5Font()
        badgeLabel.badgeColor = .dbBlueSkyBlue
        badgeLabel.textColor = .white
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let centerYConstraint = NSLayoutConstraint(
            item: titleLabel,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerY,
            multiplier: 1.0,
            constant: 0)
        
        let centerXConstraint = NSLayoutConstraint(
            item: titleLabel,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0)
        
        let badgeLeftConstraint = NSLayoutConstraint(
            item: badgeLabel,
            attribute: .leading,
            relatedBy: .equal,
            toItem: titleLabel,
            attribute: .trailing,
            multiplier: 1.0,
            constant: 5.0
        )
        
        let badgeCenterConstraint = NSLayoutConstraint(
            item: badgeLabel,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: titleLabel,
            attribute: .centerY,
            multiplier: 1.0,
            constant: 0
        )
        
        
        self.addConstraints([centerYConstraint, centerXConstraint, badgeLeftConstraint, badgeCenterConstraint])
    }
    
    override func updateConstraints() {
        super.updateConstraints()
    }
}

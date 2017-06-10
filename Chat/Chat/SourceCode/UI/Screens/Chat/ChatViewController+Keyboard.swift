//
//  ChatViewController+Extensions.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/10/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import UIKit

extension ChatViewController {
    
    func showKeyboard(notification: Notification) {
        if let frame = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let height = frame.cgRectValue.height
            self.tableView.contentInset.bottom = height
            self.tableView.scrollIndicatorInsets.bottom = height
        }
    }
    
    func hideKeyboard() {
        self.bottomConstraint.constant = 0
        UIView.animate(
            withDuration: 0.25,
            delay: 0,
            options: UIViewAnimationOptions(),
            animations: {
                
            self.inputBarView.layoutIfNeeded()
        },
            completion: { bool in
        })
    }
    
}

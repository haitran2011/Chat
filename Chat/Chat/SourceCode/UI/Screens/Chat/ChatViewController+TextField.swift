//
//  ChatViewController+TextField.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/10/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import UIKit

extension ChatViewController: UITextFieldDelegate{
    
    override var inputAccessoryView: UIView?{
        get {
            self.inputBarView.frame.size.height = self.barHeight
            self.inputBarView.clipsToBounds = true
            return self.inputBarView
        }
    }
    override var canBecomeFirstResponder: Bool{
        return true
    }
}

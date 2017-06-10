//
//  ChatViewController+SWTableView.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/10/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import UIKit
import SWTableViewCell

extension ChatsViewController: SWTableViewCellDelegate {
    func swipeableTableViewCellShouldHideUtilityButtons(onSwipe cell: SWTableViewCell!) -> Bool {
        return true
    }
    
    func swipeableTableViewCell(_ cell: SWTableViewCell!, didTriggerLeftUtilityButtonWith index: Int) {
        
    }
}

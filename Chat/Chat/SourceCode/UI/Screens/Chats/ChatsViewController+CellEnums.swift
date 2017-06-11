//
//  ChatsViewController+CellEnums.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/11/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import UIKit

extension ChatsContentType {
    func chatCell(_ tableView: UITableView, indexPath: IndexPath, item: DB2Channel, viewController: ChatsViewController) -> UITableViewCell? {
        switch self {
        case .withText:
            let cell: MessageCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.updateFromModel(model: item)
            cell.setBadge(count: item.unreadMessagesCount)
            cell.selectionStyle = .none
            viewController.configureLeftUtilityButtons()
            cell.leftUtilityButtons = viewController.leftUtilityButtons as! [Any]
            cell.delegate = viewController
            return cell
        }
    }
}

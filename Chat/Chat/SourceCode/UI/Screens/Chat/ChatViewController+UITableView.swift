//
//  ChatViewController+UITableView.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/10/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import UIKit

// MARK: - @protocol UITableViewDelegate
extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.inputTextField.resignFirstResponder()
    }
}

// MARK: - @protocol UITableViewDataSource
extension ChatViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tmp == nil {
        } else {
            if let prevDate = tmp?.createDate.dateFromISO8601,
                let nextDate = dataSource[indexPath.row].createDate.dateFromISO8601 {
                if Calendar.current.isDate(prevDate, inSameDayAs: nextDate) {
                    
                } else {
                }
            }
        }
        tmp = dataSource[indexPath.row]
        
        if dataSource[indexPath.row].sender.id == UserManager.sharedInstance.userId {
            let cell: ReceiverCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.messageTextView.text = dataSource[indexPath.row].text
            cell.timeLabel.text = dataSource[indexPath.row].createDate.dateFromISO8601?.toString(format: "HH:mm")
            return cell
        }  else {
            let cell: SenderCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.messageTextView.text = dataSource[indexPath.row].text
            cell.timeLabel.text = dataSource[indexPath.row].createDate.dateFromISO8601?.toString(format: "HH:mm")
            return cell
        }
    }
}

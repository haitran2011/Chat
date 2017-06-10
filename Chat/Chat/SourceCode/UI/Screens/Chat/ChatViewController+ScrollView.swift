//
//  ChatViewController+ScrollView.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/10/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import UIKit

extension ChatViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y < loadMoreOffset) {
            if self.isEndRefreshing {
                self.pullToLoadMore()
                print("pull to refresh")
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.hideKeyboard()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (scrollView.contentOffset.y - scrollView.contentInset.top < loadMoreOffset) {
            if self.isEndRefreshing {
                self.pullToLoadMore()
                print("pull to refresh");
            }
        }
    }
}

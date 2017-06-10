//
//  UserInstance.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/10/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import Foundation

final class UserManager {
    class var sharedInstance : UserManager {
        struct Static {
            static let instance : UserManager = UserManager()
        }
        return Static.instance
    }
    
    var userId: Int? {
        get { return 1947 /* hardcoder dummy user id */ }
        set (newValue) { /*save to user defaults*/ }
    }
}

//
//  RDB2Users.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/9/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import Realm
import RealmSwift

final class RDB2Users: Object {
    let users = List<RDB2Sender>()
}

extension RDB2Users: DomainConvertibleType {
    func asDomain() -> [DB2Sender] {
        return Array<DB2Sender>()
    }
}

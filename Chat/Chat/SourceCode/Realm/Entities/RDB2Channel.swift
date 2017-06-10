//
//  RDB2Channel.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/7/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import Realm
import RealmSwift

final class RDB2Channel: Object {
    dynamic var lastMessage: RDB2LastMessage?
    dynamic var users: RDB2Users?
    dynamic var id: Int = 0
    dynamic var unreadMessagesCount: Int = 0
}

extension RDB2Channel: DomainConvertibleType {
    func asDomain() -> DB2Channel {
        return DB2Channel(lastMessage: lastMessage!.asDomain(),
                          users: users!.asDomain(),
                          id: id,
                          unreadMessagesCount: unreadMessagesCount)
    }
}

extension DB2Channel: RealmRepresentable {
    internal var uid: String {
        return ""
    }
    
    func asRealm() -> RDB2Channel {
        return RDB2Channel.build { object in
           object.lastMessage = lastMessage.asRealm()
        }
    }
}


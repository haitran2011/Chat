//
//  RDB2LastMessage.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/7/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import Realm
import RealmSwift

final class RDB2LastMessage: Object {
    dynamic var sender: RDB2Sender?
    dynamic var text: String = ""
    dynamic var isRead: Bool = false
    dynamic var createDate: String = ""
}

extension RDB2LastMessage: DomainConvertibleType {
    func asDomain() -> DB2LastMessage {
        return DB2LastMessage(
            sender: sender!.asDomain(),
            text: text,
            isRead: isRead,
            createDate: createDate)
    }
}

extension DB2LastMessage: RealmRepresentable {
    internal var uid: String {
        return ""
    }
    
    func asRealm() -> RDB2LastMessage{
        return RDB2LastMessage.build{ object in
            object.sender = sender.asRealm()
            object.text = text
            object.isRead = isRead
            object.createDate = createDate
        }
    }
}

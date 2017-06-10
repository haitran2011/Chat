//
//  RDB2Message.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/7/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import Realm
import RealmSwift

final class RDB2Message: Object {
    dynamic var sender: RDB2Sender?
    dynamic var text: String = ""
    dynamic var isRead: Bool = false
    dynamic var createDate: String = ""
}

extension RDB2Message: DomainConvertibleType {
    func asDomain() -> DB2Message {
        return DB2Message(
            sender: sender!.asDomain(),
            text: text,
            isRead: isRead,
            createDate: createDate)
    }
}

extension DB2Message: RealmRepresentable {
    internal var uid: String {
        return ""
    }
    
    func asRealm() -> RDB2Message {
        return RDB2Message.build{ object in
            object.sender = sender.asRealm()
            object.text = text
            object.isRead = isRead
            object.createDate = createDate
        }
    }
}

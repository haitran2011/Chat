//
//  RDB2Sender.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/7/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import Realm
import RealmSwift

final class RDB2Sender: Object {
    dynamic var lastName: String = ""
    dynamic var id: Int = 0
    dynamic var firstName: String = ""
    dynamic var username: String = ""
    dynamic var photo: String = ""
}

extension RDB2Sender: DomainConvertibleType {
    func asDomain() -> DB2Sender {
        return DB2Sender(
            lastName: lastName,
            id: id,
            firstName: firstName,
            username: username,
            photo: photo)
    }
}

extension DB2Sender: RealmRepresentable {
   internal var uid: String {
        return ""
    }

    func asRealm() -> RDB2Sender {
        return RDB2Sender.build{ object in
            object.lastName = lastName
            object.id = id
            object.firstName = firstName
            object.username = username
            object.photo = photo
        }
    }
}

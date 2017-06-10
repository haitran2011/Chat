//
//  RealmRepresentable.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/7/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import Foundation

protocol RealmRepresentable {
    associatedtype RealmType: DomainConvertibleType
    
    var uid: String {get}
    func asRealm() -> RealmType
}

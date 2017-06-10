//
//  DomainConvertibleType.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/7/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import Foundation

protocol DomainConvertibleType {
    associatedtype DomainType
    func asDomain() -> DomainType
}

//
//  DB2Sender.swift
//
//  Created by Alexey Shtanko on 6/6/17
//  Copyright (c) . All rights reserved.
//

import ObjectMapper

extension DB2Sender: ImmutableMappable {
    
    public init(map: Map) throws {
        lastName    = try map.value(MapperKeys.lastName)
        id          = try map.value(MapperKeys.id)
        firstName   = try map.value(MapperKeys.firstName)
        username    = try map.value(MapperKeys.username)
        photo       = try map.value(MapperKeys.photo)
    }
}

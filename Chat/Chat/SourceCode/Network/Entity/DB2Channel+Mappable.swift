//
//  DB2Channels.swift
//
//  Created by Alexey Shtanko on 6/6/17
//  Copyright (c) . All rights reserved.
//

import ObjectMapper

extension DB2Channel: ImmutableMappable {
    
    public init(map: Map) throws {
        lastMessage         = try map.value(MapperKeys.lastMessage)
        users               = try map.value(MapperKeys.users)
        id                  = try map.value(MapperKeys.id)
        unreadMessagesCount = try map.value(MapperKeys.unreadMessagesCount)
    }
}

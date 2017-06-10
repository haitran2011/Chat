//
//  DB2LastMessage.swift
//
//  Created by Alexey Shtanko on 6/6/17
//  Copyright (c) . All rights reserved.
//

import ObjectMapper

extension DB2LastMessage: ImmutableMappable {
    
    public init(map: Map) throws {
        sender      = try map.value(MapperKeys.sender)
        text        = try map.value(MapperKeys.text)
        isRead      = try map.value(MapperKeys.isRead)
        createDate  = try map.value(MapperKeys.createDate)
    }
}

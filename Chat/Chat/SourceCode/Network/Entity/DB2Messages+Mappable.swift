//
//  DB2Messages+Mappable.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/7/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import ObjectMapper

extension DB2Messages: ImmutableMappable {
    public init(map: Map) throws {
        messages = try map.value(MapperKeys.messages)
    }
}

//
//  DB2Channels+Mappable.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/7/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import ObjectMapper

extension DB2Channels: ImmutableMappable {
    public init(map: Map) throws {
        channels = try map.value(MapperKeys.channels)
    }
}

//
//  DB2Channels.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/6/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

public struct DB2Channel {
    
    public let lastMessage: DB2LastMessage
    public let users: [DB2Sender]
    public let id: Int
    public let unreadMessagesCount: Int
    
    public init(lastMessage: DB2LastMessage,
                users: [DB2Sender],
                id: Int,
                unreadMessagesCount: Int) {
        
        self.lastMessage = lastMessage
        self.users = users
        self.id = id
        self.unreadMessagesCount = unreadMessagesCount
    }
}

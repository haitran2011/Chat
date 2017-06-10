//
//  DB2Messages.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/6/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

public struct DB2Message {

    public let sender: DB2Sender
    public let text: String
    public let isRead: Bool
    public let createDate: String
    
    public init(sender: DB2Sender,
                text: String,
                isRead: Bool,
                createDate: String) {
    
        self.sender = sender
        self.text = text
        self.isRead = isRead
        self.createDate = createDate
    }
    
}

//
//  DB2Sender.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/6/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

public struct DB2Sender {

    public let lastName: String
    public let id: Int
    public let firstName: String
    public let username: String
    public let photo: String
    
    public init(lastName: String,
                id: Int,
                firstName: String,
                username: String,
                photo: String) {
    
        self.lastName = lastName
        self.id = id
        self.firstName = firstName
        self.username = username
        self.photo = photo
    }

    
}

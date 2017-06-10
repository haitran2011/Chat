//
//  MessagesNetwork.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/6/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import RxSwift

public final class MessagesNetwork {
    
    private let network: Network<DB2Messages>

    init(network: Network<DB2Messages>) {
        self.network = network
    }
    
    public func fetchMessages()-> Observable<DB2Messages> {
        return network.getMessages("/1/messages")
    }
}

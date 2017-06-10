//
//  MessagesUseCase.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/6/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import RxSwift

final class MessagesUseCase: DomainMessagesUseCase {
    
    private let network: MessagesNetwork
    
    init(network: MessagesNetwork) {
        self.network = network
    }
    
    func messages() -> Observable<DB2Messages> {
        return network.fetchMessages()
    }
}

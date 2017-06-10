//
//  NetworkSaveChannelsUseCase.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/9/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import RxSwift

final class NetworkSaveChannelsUseCase: DomainSaveChannelsUseCase {
    private let network: ChannelsNetwork
    
    init(network: ChannelsNetwork) {
        self.network = network
    }
    
    func save(channel: DB2Channel) -> Observable<Void> {
        return network.fetchChannels().map{_ in}
    }
}

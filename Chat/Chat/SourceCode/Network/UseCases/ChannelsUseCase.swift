//
//  ChannelsUseCase.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/7/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import RxSwift


final class ChannelsUseCase: DomainChannelsUseCase {
    private let network: ChannelsNetwork
    
    init(network: ChannelsNetwork) {
        self.network = network
    }
    
    func channels() -> Observable<DB2Channels> {
        return network.fetchChannels()
    }
}

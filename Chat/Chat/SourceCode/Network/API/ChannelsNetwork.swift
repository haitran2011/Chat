//
//  ChannelsNetwork.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/6/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import RxSwift

public final class ChannelsNetwork {
    
    private let network: Network<DB2Channels>
    
    init(network: Network<DB2Channels>) {
        self.network = network
    }
    
    public func fetchChannels() -> Observable<DB2Channels> {
        return network.getChannels("")
    }
    
    
}

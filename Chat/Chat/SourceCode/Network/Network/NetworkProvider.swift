//
//  NetworkProvider.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/6/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

final class NetworkProvider {
    private let apiEndpoint: String
    
    public init() {
        apiEndpoint = Config.apiEndpoint
    }
    
    public func makeMessagesNetwork() -> MessagesNetwork {
        let network = Network<DB2Messages>(apiEndpoint)
        return MessagesNetwork(network: network)
    }
    
    public func makeChannelsNetwork() -> ChannelsNetwork {
        let network = Network<DB2Channels>(apiEndpoint)
        return ChannelsNetwork(network:network)
    }
}

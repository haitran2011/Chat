//
//  NetworkUseCaseProvider.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/6/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

public final class NetworkUseCaseProvider: DomainUseCaseProvider {
    
    private let networkProvider: NetworkProvider
    
    public init() {
        networkProvider = NetworkProvider()
    }
    
    public func makeSaveChannelsUseCase() -> DomainSaveChannelsUseCase {
        return NetworkSaveChannelsUseCase(network: networkProvider.makeChannelsNetwork())
    }
    
    public func makeMessagesUseCase() -> DomainMessagesUseCase {
        return MessagesUseCase(network: networkProvider.makeMessagesNetwork())
    }
    
    public func makeChannelsUseCase() -> DomainChannelsUseCase {
        return ChannelsUseCase(network: networkProvider.makeChannelsNetwork())
    }

}


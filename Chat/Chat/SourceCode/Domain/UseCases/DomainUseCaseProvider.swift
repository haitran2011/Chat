//
//  UseCaseProvider.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/6/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

public protocol DomainUseCaseProvider {
    func makeMessagesUseCase() -> DomainMessagesUseCase
    func makeChannelsUseCase() -> DomainChannelsUseCase
    func makeSaveChannelsUseCase() -> DomainSaveChannelsUseCase
}

//
//  RealmUseCaseProvider.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/9/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import Realm
import RealmSwift

class RealmUseCaseProvider: DomainUseCaseProvider {
    
    private let configuration: Realm.Configuration
    
    public init(configuration: Realm.Configuration = Realm.Configuration()) {
        self.configuration = configuration
    }
    
    func makeSaveChannelsUseCase() -> DomainSaveChannelsUseCase {
        let repository = Repository<DB2Channel>(configuration: configuration)
        return RealmSaveChatsUseCase(repository: repository)
    }
    
    func makeChannelsUseCase() -> DomainChannelsUseCase {
        let repository = Repository<DB2Channel>(configuration: configuration)
        return RealmChannelsUseCase(repository: repository)
    }
    
    func makeMessagesUseCase() -> DomainMessagesUseCase {
        let repository = Repository<DB2Message>(configuration: configuration)
        return RealmMessagesUseCase(repository: repository)
    }
}

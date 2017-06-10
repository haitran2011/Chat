//
//  SaveChatsUseCase.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/9/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import RxSwift

final class RealmSaveChatsUseCase: DomainSaveChannelsUseCase {
     private let repository: AbstractRepository<DB2Channel>
    
    init(repository: AbstractRepository<DB2Channel>) {
        self.repository = repository
    }
    
    func save(channel: DB2Channel) -> Observable<Void> {
        return repository.save(entity: channel)
    }
}

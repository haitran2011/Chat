//
//  RealmChannelsUseCase.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/9/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import RxSwift

final class RealmChannelsUseCase: DomainChannelsUseCase {
    
    private let repository: AbstractRepository<DB2Channel>
    
    init(repository: AbstractRepository<DB2Channel>) {
        self.repository = repository
    }
    
    func channels() -> Observable<DB2Channels> {
        var arr = [DB2Channel]()
        repository.queryAll().subscribe{
            if let element = $0.element{
                arr.append(contentsOf: element)
            }
            }.dispose()
        return Observable.just(DB2Channels(channels: arr))
    }
}

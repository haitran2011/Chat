//
//  AllChatsUseCase.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/9/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import RxSwift

final class RealmMessagesUseCase: DomainMessagesUseCase {
    
    private let repository: AbstractRepository<DB2Message>
    
    init(repository: AbstractRepository<DB2Message>) {
        self.repository = repository
    }

    func messages() -> Observable<DB2Messages> {
        var arr = [DB2Message]()
        repository.queryAll().subscribe{
            if let element = $0.element{
                arr.append(contentsOf: element)
            }
        }.dispose()
        return Observable.just(DB2Messages(messages: arr))
    }
}

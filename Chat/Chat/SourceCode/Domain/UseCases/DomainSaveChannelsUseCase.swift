//
//  DomainSaveChannelsUseCase.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/9/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import RxSwift

public protocol DomainSaveChannelsUseCase {
    func save(channel: DB2Channel) -> Observable<Void>
}

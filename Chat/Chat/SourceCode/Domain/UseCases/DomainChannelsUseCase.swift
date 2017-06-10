//
//  DomainChannelsUseCase.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/7/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//
import RxSwift

public protocol DomainChannelsUseCase {
    func channels() -> Observable<DB2Channels>
}

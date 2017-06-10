//
//  MessageUseCase.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/6/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import RxSwift

public protocol DomainMessagesUseCase {
     func messages() -> Observable<DB2Messages>
}

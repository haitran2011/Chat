//
//  ChatViewModel.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/6/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import RxSwift
import RxCocoa

class ChatViewModel:ViewModelType {
    private let chat: DB2Channel
    struct Input {
        let trigger: Driver<Void>
        let titleTrigger: Observable<Void>
    }
    
    struct Output {
        let messages:Driver<[DB2Message]>
        let title:Observable<String>
    }
    
    private let useCase: DomainMessagesUseCase
    
    init(chat: DB2Channel, useCase: DomainMessagesUseCase) {
        self.useCase = useCase
        self.chat = chat
    }
    
    func transform(input: Input) -> Output {
        let messages = input.trigger.flatMapLatest({
            return self.useCase.messages().map{$0.messages.sorted{object1, object2 in
                return object1.createDate < object2.createDate
                }}.asDriver(onErrorJustReturn: [])
        })
        
        let title = Observable.just("\(chat.lastMessage.sender.firstName) \(chat.lastMessage.sender.lastName)")
        return Output(messages: messages, title: title)
    }
}

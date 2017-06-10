//
//  MessagesViewModel.swift
//  Messages
//
//  Created by Alexey Shtanko on 6/6/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import RxSwift
import RxCocoa

final class ChatsViewModel: ViewModelType {
    
    struct Input {
        let trigger: Observable<Void>
        let driverTrigger: Driver<Void>
        let saveTrigger: Driver<Void>
        let selection: Driver<IndexPath>
    }
    
    struct Output {
        let sections:Observable<[MessagesSectionModel]>
        let unreadableMessageCount:Observable<Int>
        let selectedChat: Driver<DB2Channel>
    }
    
    private let useCase: DomainChannelsUseCase
    private let saveUseCase:DomainSaveChannelsUseCase
    private let navigator: DefaultChatsNavigator
    
    init(useCase: DomainChannelsUseCase, saveUseCase:DomainSaveChannelsUseCase, navigator: DefaultChatsNavigator) {
        self.useCase = useCase
        self.saveUseCase = saveUseCase
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        
        let activityIndicator = ActivityIndicator()
        
        //        let save = input.saveTrigger.flatMapLatest({
        //            return self.useCase
        //                .channels()
        //                .map{$0.channels.filter{$0.unreadMessagesCount == 0}}
        //        })
    
        let channels = input.trigger.flatMapLatest({
            return self.useCase.channels().trackActivity(activityIndicator)
        })
        
        let readChannels = input.trigger.flatMapLatest({
            return channels
                .map{$0.channels.filter{$0.unreadMessagesCount == 0}}
        })
        
        let unreadChannels = input.trigger.flatMapLatest({
            return channels
                .map{$0.channels.filter{$0.unreadMessagesCount > 0}}
        })
        
        let sections = input.trigger.flatMapLatest({
            return Observable.zip(unreadChannels, readChannels) { (unread, read) throws -> [MessagesSectionModel] in
                let unreadSorted = unread.sorted { (object1, object2) in
                    return object1.lastMessage.createDate  < object2.lastMessage.createDate
                }
                
                let readSorted = read.sorted{ (object1, object2) in
                    return object1.lastMessage.createDate < object2.lastMessage.createDate
                }
                
                var unreadableArray = [ChannelSectionItem]()
                var readableArray = [ChannelSectionItem]()
                var sectionsArr = [MessagesSectionModel]()
                for u in unreadSorted {
                    unreadableArray.append(ChannelSectionItem.MessagesSectionItem(item:u))
                }
                
                for r in readSorted {
                    readableArray.append(ChannelSectionItem.MessagesSectionItem(item:r))
                }
                sectionsArr.append(MessagesSectionModel.UnreadableMessagesSection(title: "", items: unreadableArray))
                sectionsArr.append(MessagesSectionModel.ReadableMessagesSection(title: "", items: readableArray))
                return sectionsArr
            }
        })
        
        let unreadableMessageCount = unreadChannels.map{$0.count}
        
        let allChannels = input.driverTrigger.flatMapLatest {
            return self.useCase.channels().map{$0.channels.sorted { (object1, object2) in
                return object1.lastMessage.createDate < object2.lastMessage.createDate
                }}.asDriver(onErrorJustReturn: [])
        }
        
        let selectedChat = input.selection
            .withLatestFrom(allChannels) { (indexPath, chats) -> DB2Channel in
                return chats[indexPath.row]
            }
            .do(onNext: navigator.toMessages)
        
        return Output(sections: sections,
                      unreadableMessageCount: unreadableMessageCount,
                      selectedChat: selectedChat
        )}
}

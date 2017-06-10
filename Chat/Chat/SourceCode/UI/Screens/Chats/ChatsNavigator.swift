//
//  ChatsNavigator.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/10/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import UIKit

protocol ChatsNavigator {
    func toMain()
    func toChats()
    func toLiveChat()
    func toMessages(_ channel: DB2Channel)
}

class DefaultChatsNavigator: ChatsNavigator {
    
    private let storyboard: [UIStoryboard]
    private let navigationController: UINavigationController
    private let services: DomainUseCaseProvider
    
    init(services: DomainUseCaseProvider,
         navigationController: UINavigationController,
         storyboard: [UIStoryboard]) {
        self.services = services
        self.navigationController = navigationController
        self.storyboard = storyboard
    }
    
    func toMain() {
        let vc = storyboard[2].instantiateViewController(ofType: MainViewController.self)
        vc.networkNavigator = self
        vc.messagesViewModel = ChatsViewModel(useCase: services.makeChannelsUseCase(),
                                         saveUseCase: services.makeSaveChannelsUseCase(),
                                         navigator: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toLiveChat() {
        
    }
    
    func toChats() {
        let vc = storyboard[1].instantiateViewController(ofType: ChatsViewController.self)
        vc.viewModel = ChatsViewModel(useCase: services.makeChannelsUseCase(),
                                         saveUseCase: services.makeSaveChannelsUseCase(),
                                         navigator: self)
        navigationController.pushViewController(vc, animated: true)
    }

    
    func toMessages(_ channel: DB2Channel) {
        let vc = storyboard[1].instantiateViewController(ofType: ChatViewController.self)
        vc.viewModel = ChatViewModel(chat: channel, useCase: services.makeMessagesUseCase())
        navigationController.pushViewController(vc, animated: true)
    }
}

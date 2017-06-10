//
//  Application.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/6/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import UIKit

final class Application {
    static let shared = Application()
    
    let networkUseCaseProvider: NetworkUseCaseProvider
    private let realmUseCaseProvider: RealmUseCaseProvider
    
    private init() {
        self.networkUseCaseProvider = NetworkUseCaseProvider()
        self.realmUseCaseProvider = RealmUseCaseProvider()
    }
    
    func configure(in window: UIWindow) {
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to: #selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = UIColor.dbStatusBar
        }
        
        let mainStoryboard = Storyboard.Main.instantiate()
        let messagesStoryboard = Storyboard.Messages.instantiate()
        let chatStoryboard = Storyboard.Chat.instantiate()
        
        let cursesNavigationController = UINavigationController()
        cursesNavigationController.tabBarItem = UITabBarItem(title: "Curses",
                                                             image: UIImage(named: "curses"),
                                                             selectedImage: nil)
        
        let communityNavigationController = UINavigationController()
        communityNavigationController.tabBarItem = UITabBarItem(title: "Community",
                                                                image: UIImage(named: "community"),
                                                                selectedImage: nil)
        
        let profileNavigationController = UINavigationController()
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile",
                                                              image: UIImage(named: "profile"),
                                                              selectedImage: nil)
        
        let helpNavigationController = UINavigationController()
        helpNavigationController.tabBarItem = UITabBarItem(title: "Help",
                                                           image: UIImage(named: "help"),
                                                           selectedImage: nil)
        
        let networkNavigator = DefaultChatsNavigator(services: networkUseCaseProvider,
                                                        navigationController: cursesNavigationController,
                                                        storyboard: [messagesStoryboard,chatStoryboard,mainStoryboard])
        
        let realmNavigator = DefaultChatsNavigator(services: realmUseCaseProvider,
                                                        navigationController: cursesNavigationController,
                                                        storyboard: [messagesStoryboard,chatStoryboard,mainStoryboard])
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .white
        tabBarController.tabBar.barTintColor = .dbPurpleDark
        tabBarController.viewControllers = [
            cursesNavigationController,
            communityNavigationController,
            profileNavigationController,
            helpNavigationController
        ]
        
        window.rootViewController = tabBarController
        
        networkNavigator.toMain()
    }
}

//
//  AppDelegate.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/5/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {        
        let window = UIWindow(frame: UIScreen.main.bounds)
        Application.shared.configure(in: window)
        self.window = window
        return true
    }
}


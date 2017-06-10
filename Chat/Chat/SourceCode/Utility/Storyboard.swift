//
//  Storyboard.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/6/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import UIKit

public enum Storyboard: String {
    case Main, Messages, Chat
    
    public func instantiate(inBundle bundle: Bundle = .main) -> UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle(identifier: bundle.bundleIdentifier!))
    }
    
    public func instantiate<VC: UIViewController>(_ viewController: VC.Type,
                            inBundle bundle: Bundle = .main) -> VC {
        guard let controller = UIStoryboard(name: self.rawValue, bundle: Bundle(identifier: bundle.bundleIdentifier!))
            .instantiateViewController(withIdentifier: VC.storyboardIdentifier) as? VC
            else { fatalError("Couldn't instantiate \(VC.storyboardIdentifier) from \(self.rawValue)") }
        
        return controller
    }
}

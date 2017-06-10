//
//  UIViewController+Extensions.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/6/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import UIKit

extension UIViewController {
    public static var storyboardIdentifier: String {
        return self.description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }
}


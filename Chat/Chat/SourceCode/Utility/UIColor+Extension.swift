//
//  UIColor+Extension.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/6/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import UIKit

// Color palette

extension UIColor {
    class var dbGreyishBrown: UIColor {
        return UIColor(white: 74.0 / 255.0, alpha: 1.0)
    }
    
    class var dbSilver: UIColor {
        return UIColor(red: 199.0 / 255.0, green: 199.0 / 255.0, blue: 204.0 / 255.0, alpha: 1.0)
    }
    
    class var dbDarkSilver: UIColor {
        return UIColor(red: 121.0 / 255.0, green: 121.0 / 255.0, blue: 121.0 / 255.0, alpha: 1.0)
    }
    
    class var dbDarkSkyBlue: UIColor {
        return UIColor(red: 74.0 / 255.0, green: 144.0 / 255.0, blue: 226.0 / 255.0, alpha: 1.0)
    }
    
    class var dbBlueSkyBlue: UIColor {
        return UIColor(red: 80.0 / 255.0, green: 195.0 / 255.0, blue: 227.0 / 255.0, alpha: 1.0)
    }
    
    class var dbPurpleDark: UIColor {
        return UIColor(red: 58.0 / 255.0, green: 79.0 / 255.0, blue: 152.0 / 255.0, alpha: 1.0)
    }
    
    class var dbStatusBar: UIColor {
        return UIColor(red: 71.0 / 255.0, green: 134.0 / 255.0, blue: 206.0 / 255.0, alpha: 1.0)
    }
}

extension UIColor {
    @nonobjc public static func colorHex(_ value: UInt32) -> UIColor {
        let r = CGFloat((value & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((value & 0xFF00) >> 8) / 255.0
        let b = CGFloat((value & 0xFF)) / 255.0
        
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}

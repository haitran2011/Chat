//
//  UIView+Extension.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/7/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import QuartzCore
import UIKit

extension UIView {
    func roundCorner(corners: UIRectCorner, radius: CGFloat) {
        
        let maskPath = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        self.layer.masksToBounds = true
    }
}


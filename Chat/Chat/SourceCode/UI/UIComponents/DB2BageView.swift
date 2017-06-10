//
//  DB2BageView.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/6/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import UIKit

@IBDesignable open class DB2BadgeView: UILabel {
    
    @IBInspectable open var badgeColor: UIColor = UIColor.red {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable open var borderWidth: CGFloat = 0 {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    @IBInspectable open var borderColor: UIColor = UIColor.white {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    @IBInspectable open var insets: CGSize = CGSize(width: 5, height: 2) {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    @IBInspectable open var shadowOpacityBadge: CGFloat = 0.5 {
        didSet {
            layer.shadowOpacity = Float(shadowOpacityBadge)
            setNeedsDisplay()
        }
    }
    
    @IBInspectable open var shadowRadiusBadge: CGFloat = 0.5 {
        didSet {
            layer.shadowRadius = shadowRadiusBadge
            setNeedsDisplay()
        }
    }
    
    @IBInspectable open var shadowColorBadge: UIColor = UIColor.black {
        didSet {
            layer.shadowColor = shadowColorBadge.cgColor
            setNeedsDisplay()
        }
    }
    
    @IBInspectable open var shadowOffsetBadge: CGSize = CGSize(width: 0, height: 0) {
        didSet {
            layer.shadowOffset = shadowOffsetBadge
            setNeedsDisplay()
        }
    }
    
    @IBInspectable open var cornerRadius: CGFloat = -1 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    convenience public init() {
        self.init(frame: CGRect())
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override open func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let rect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        
        var insetsWithBorder = actualInsetsWithBorder()
        let rectWithDefaultInsets = rect.insetBy(dx: -insetsWithBorder.width, dy: -insetsWithBorder.height)
        
        if rectWithDefaultInsets.width < rectWithDefaultInsets.height {
            insetsWithBorder.width = (rectWithDefaultInsets.height - rect.width) / 2
        }
        let result = rect.insetBy(dx: -insetsWithBorder.width, dy: -insetsWithBorder.height)
        
        return result
    }
    
    override open func drawText(in rect: CGRect) {
        if cornerRadius >= 0 {
            layer.cornerRadius = cornerRadius
        }else {
            layer.cornerRadius = rect.height / 2
        }
        
        let insetsWithBorder = actualInsetsWithBorder()
        let insets = UIEdgeInsets(
            top: insetsWithBorder.height,
            left: insetsWithBorder.width,
            bottom: insetsWithBorder.height,
            right: insetsWithBorder.width)
        
        let rectWithoutInsets = UIEdgeInsetsInsetRect(rect, insets)
        
        super.drawText(in: rectWithoutInsets)
    }
    
    override open func draw(_ rect: CGRect) {
        let rectInset = rect.insetBy(dx: borderWidth/2, dy: borderWidth/2)
        
        let actualCornerRadius = cornerRadius >= 0 ? cornerRadius : rect.height/2
        
        var path: UIBezierPath?
        
        if actualCornerRadius == 0 {
            path = UIBezierPath(rect: rectInset)
        } else {
            path = UIBezierPath(roundedRect: rectInset, cornerRadius: actualCornerRadius)
        }
        
        badgeColor.setFill()
        path?.fill()
        
        if borderWidth > 0 {
            borderColor.setStroke()
            path?.lineWidth = borderWidth
            path?.stroke()
        }
        
        super.draw(rect)
    }
    
    private func setup() {
        textAlignment = NSTextAlignment.center
        clipsToBounds = false
    }
    
    private func actualInsetsWithBorder() -> CGSize {
        return CGSize(
            width: insets.width + borderWidth,
            height: insets.height + borderWidth
        )
    }
    
    @available(iOS 8.0, *)
    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        setup()
        setNeedsDisplay()
    }
}


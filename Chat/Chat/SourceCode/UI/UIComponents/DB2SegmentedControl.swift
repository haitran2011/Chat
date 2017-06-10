//
//  DB2SegmentedControl.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/5/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import UIKit

@IBDesignable class DB2SegmentedControl: UIControl {
    
    private var views = [DB2ControlView]()
    var thumbView = UIView()
    
    var items: [String] = ["Item1", "Item2"] {
        didSet {
            setupViews()
        }
    }
    
    var selectedIndex : Int = 0 {
        didSet {
            displayNewSelectedIndex()
        }
    }
    
    @IBInspectable var selectedLabelColor : UIColor = .dbGreyishBrown {
        didSet {
            setSelectedColors()
        }
    }
    
    @IBInspectable var unselectedLabelColor : UIColor = UIColor.gray {
        didSet {
            setSelectedColors()
        }
    }
    
    @IBInspectable var thumbColor : UIColor = UIColor.white {
        didSet {
            setSelectedColors()
        }
    }
    
    @IBInspectable var borderColor : UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var font : UIFont! = UIFont.systemFont(ofSize: 12) {
        didSet {
            setFont()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView(){
        layer.cornerRadius = frame.height / 2
        layer.borderColor = UIColor(white: 1.0, alpha: 0.5).cgColor
        layer.borderWidth = 0
        setupViews()
        
        addIndividualItemConstraints(views, mainView: self, padding: 0)
        insertSubview(thumbView, at: 0)
    }
    
    func setupBadge(indexOfItem index:Int, countValue count:Int) {
        if views.count <= index {
            return
        }
        if count > 0 {
            self.views[index].badgeLabel.isHidden = false
            self.views[index].badgeLabel.text = "\(count)"
        } else {
            self.views[index].badgeLabel.isHidden = true
        }
    }
    
    func setupViews(){
        
        for controlView in views {
            controlView.removeFromSuperview()
        }
        
        views.removeAll(keepingCapacity: true)
        
        for index in 1...items.count {
            let controlView = DB2ControlView()
            controlView.badgeLabel.isHidden = true
            controlView.titleLabel.text = items[index - 1]
            controlView.backgroundColor = UIColor.clear
            controlView.titleLabel.textAlignment = .center
            controlView.titleLabel.font = .dbTextStyle2Font()
            controlView.titleLabel.textColor = index == 1 ? self.selectedLabelColor : self.unselectedLabelColor
            controlView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(controlView)
            views.append(controlView)
        }
        addIndividualItemConstraints(views, mainView: self, padding: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var selectFrame = self.bounds
        let newWidth = selectFrame.width / CGFloat(items.count)
        selectFrame.size.width = newWidth
        thumbView.frame = selectFrame
        thumbView.backgroundColor = thumbColor
        thumbView.layer.cornerRadius = thumbView.frame.height / 2
        displayNewSelectedIndex()
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        let location = touch.location(in: self)
        
        var calculatedIndex : Int?
        for (index, item) in views.enumerated() {
            if item.frame.contains(location) {
                calculatedIndex = index
            }
        }
        
        if calculatedIndex != nil {
            selectedIndex = calculatedIndex!
            sendActions(for: .valueChanged)
        }
        
        return false
    }
    
    func displayNewSelectedIndex(){
        for (_, item) in views.enumerated() {
            item.titleLabel.textColor = unselectedLabelColor
        }
        
        let controlView = views[selectedIndex]
        controlView.titleLabel.textColor = selectedLabelColor
        
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0.8, options: [], animations: {
            
            self.thumbView.frame = controlView.frame
            
        }, completion: nil)
    }
    
    func addIndividualItemConstraints(_ items: [UIView], mainView: UIView, padding: CGFloat) {
        
        for (index, button) in items.enumerated() {
            
            let topConstraint = NSLayoutConstraint(
                item: button,
                attribute: .top,
                relatedBy: .equal,
                toItem: mainView,
                attribute: .top,
                multiplier: 1.0,
                constant: 0)
            
            let bottomConstraint = NSLayoutConstraint(
                item: button,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: mainView,
                attribute: .bottom,
                multiplier: 1.0,
                constant: 0)
            
            var rightConstraint : NSLayoutConstraint!
            
            if index == items.count - 1 {
                
                rightConstraint = NSLayoutConstraint(
                    item: button,
                    attribute: .right,
                    relatedBy: .equal,
                    toItem: mainView,
                    attribute: .right,
                    multiplier: 1.0,
                    constant: -padding)
                
            }else{
                
                let nextButton = items[index+1]
                
                rightConstraint = NSLayoutConstraint(
                    item: button,
                    attribute: .right,
                    relatedBy: .equal,
                    toItem: nextButton,
                    attribute: .left,
                    multiplier: 1.0,
                    constant: -padding)
            }
            
            
            var leftConstraint : NSLayoutConstraint!
            
            if index == 0 {
                leftConstraint = NSLayoutConstraint(
                    item: button,
                    attribute: .left,
                    relatedBy: .equal,
                    toItem: mainView,
                    attribute: .left,
                    multiplier: 1.0,
                    constant: padding)
                
            }else{
                
                let prevButton = items[index-1]
                
                leftConstraint = NSLayoutConstraint(
                    item: button,
                    attribute: .left,
                    relatedBy: .equal,
                    toItem: prevButton,
                    attribute: .right,
                    multiplier: 1.0,
                    constant: padding)
                
                let firstItem = items[0]
                
                let widthConstraint = NSLayoutConstraint(
                    item: button,
                    attribute: .width,
                    relatedBy: .equal,
                    toItem: firstItem,
                    attribute: .width,
                    multiplier: 1.0,
                    constant: 0)
                
                mainView.addConstraint(widthConstraint)
            }
            
            mainView.addConstraints([topConstraint, bottomConstraint, rightConstraint, leftConstraint])
        }
    }
    
    func setSelectedColors(){
        for item in views {
            item.titleLabel.textColor = unselectedLabelColor
        }
        
        if views.count > 0 {
            views[0].titleLabel.textColor = selectedLabelColor
        }
        
        thumbView.backgroundColor = thumbColor
    }
    
    func setFont(){
        for item in views {
            item.titleLabel.font = font
        }
    }
}


//
//  ReusableView+Exstension.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/6/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import UIKit

protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

extension UITableView {
    
    func register<C: UITableViewCell>(_: C.Type) where C: ReusableView {
        register(C.self, forCellReuseIdentifier: C.defaultReuseIdentifier)
    }
    
    func register<C: UITableViewCell>(_: C.Type) where C: ReusableView, C: NibLoadableView, C: ReusableView, C: NibLoadableView {
        let bundle = Bundle(for: C.self)
        let nib = UINib(nibName: C.nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: C.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<C: UITableViewCell> (forIndexPath indexPath: IndexPath) -> C where C: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: C.defaultReuseIdentifier, for: indexPath as IndexPath) as? C else {
            fatalError("Could not dequeue cell with identifier: \(C.defaultReuseIdentifier)")
        }
        return cell
    }
}

protocol UIViewNibLoadable {}
extension UIView : UIViewNibLoadable {}

extension UIViewNibLoadable where Self : UIView {
    static func instanciateFromNib() -> Self {
        let nibName = "\(self)".characters.split {$0 == "."}.map(String.init).last!
        let nib = UINib(nibName: nibName, bundle: nil)
        guard let value = nib.instantiate(withOwner: self, options: nil).first as? Self else {
            fatalError("Could not load nib file")
        }
        return value
    }
}


//
//  MainViewController.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/10/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, ChatBadgeDelegate {
    
    @IBOutlet weak var segmentControl: DB2SegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    var networkNavigator: DefaultChatsNavigator?
    var messagesViewModel:ChatsViewModel?
    
    private lazy var liveChatViewController: LiveChatViewController = {
        let chatStoryboard = Storyboard.Chat.instantiate()
        let vc = chatStoryboard.instantiateViewController(ofType: LiveChatViewController.self)
        self.add(asChildViewController: vc)
        return vc
    }()
    
    // MARK: ChatBadgeDelegate
    func onBadge(count: Int) {
          self.segmentControl.setupBadge(indexOfItem: 0, countValue: count)
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        addChildViewController(viewController)
        view.addSubview(viewController.view)
        viewController.view.frame = CGRect(x: 0, y: segmentControl.frame.size.height + 20, width: self.view.frame.size.width, height: self.view.frame.height)
        
        //viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParentViewController: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }
    
    fileprivate func configureSegmentControl() {
        segmentControl.items = ["Chat", "Live Chat"]
        segmentControl.font = UIFont(name: "Avenir-Black", size: 12)
        segmentControl.borderColor = UIColor(white: 1.0, alpha: 0.3)
        segmentControl.selectedIndex = 0
        segmentControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
        addChatsVC()
    }
    
    func configureNavigationVC() {
        self.navigationItem.title = "Chats"
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        
        let newChatIcon = UIImage.init(named: "newChat")?.withRenderingMode(.alwaysOriginal)
        let newChatButton = UIBarButtonItem.init(image: newChatIcon!, style: .plain, target: self, action: #selector(self.newChatAction))
        
        self.navigationItem.rightBarButtonItem = newChatButton
        navigationController?.toolbar.clipsToBounds = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.toolbar.layer.borderWidth = 0.0
        navigationController?.navigationBar.backgroundColor = .dbDarkSkyBlue
        self.navigationController?.navigationBar.barTintColor = .dbDarkSkyBlue
        self.navigationController?.navigationBar.barStyle = .default
        navigationController?.toolbar.backgroundColor = .dbDarkSkyBlue
        navigationController?.navigationBar.clipsToBounds = true
        self.navigationItem.setHidesBackButton(true, animated: false)
        let backIcon = UIImage.init(named: "back")?.withRenderingMode(.alwaysOriginal)
        let backButton = UIBarButtonItem.init(image: backIcon!, style: .plain, target: self, action: #selector(self.dismissSelf))
        
        self.navigationItem.leftBarButtonItem?.title = "Back"
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func newChatAction() {
        
    }
    
    func dismissSelf() {
        
    }
    
    func addChatsVC() {
        let vc = Storyboard.Chat.instantiate().instantiateViewController(ofType: ChatsViewController.self)
        if let vm = messagesViewModel {
            vc.viewModel = vm
            vc.badgeDelegate = self
            remove(asChildViewController: vc)
            add(asChildViewController: vc)
        }
    }
    
    func selectionDidChange(_ sender: UISegmentedControl) {
        switch segmentControl.selectedIndex {
        case 0:
            addChatsVC()
            break
        case 1:
            remove(asChildViewController: liveChatViewController)
            add(asChildViewController: liveChatViewController)
            break
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSegmentControl()
        self.configureNavigationVC()
    }
    
}

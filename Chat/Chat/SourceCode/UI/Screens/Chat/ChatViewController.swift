//
//  ChatViewController.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/5/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

let loadMoreOffset: CGFloat = 10

final class ChatViewController: UIViewController {
    private let disposeBag = DisposeBag()
    var viewModel:ChatViewModel!
    
    @IBOutlet var refreshView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var inputBarView: UIView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    let imagePicker = UIImagePickerController()
    let barHeight: CGFloat = 50
    var isEndRefreshing: Bool = true
    var isReloading: Bool = false
    var dataSource = [DB2Message]()
    var tmp: DB2Message?
    
    func configureViews() {
        activityIndicator.isHidden = true
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        self.imagePicker.delegate = self
        self.inputBarView.layoutIfNeeded()
        inputAccessoryView?.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.inputBarView.layoutIfNeeded()
        }
    }
    
    @IBAction func selectPhotoAction(_ sender: Any) {
        self.imagePicker.sourceType = .photoLibrary
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    func configureTableView() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(ReceiverCell.self)
        self.tableView.register(SenderCell.self)
        self.tableView.allowsSelection = false
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = self.barHeight
        self.tableView.contentInset.bottom = self.barHeight
        self.tableView.scrollIndicatorInsets.bottom = self.barHeight
        self.tableView.tableHeaderView = self.refreshView
        
        let tap = UITapGestureRecognizer()
        tap.cancelsTouchesInView = false
        self.tableView.addGestureRecognizer(tap)
        tap.rx.event.subscribe {[weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.hideKeyboard()
        }.addDisposableTo(self.disposeBag)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    fileprivate func bindViewModel() {
        assert(viewModel != nil)
        
        let input = ChatViewModel.Input(trigger: Driver.just(), titleTrigger:Observable.just())
        let output = viewModel.transform(input: input)
        output.title.bind(to: navigationItem.rx.title).addDisposableTo(disposeBag)
        
        output.messages.map{$0}.asObservable().subscribe{[unowned self] it in
            if let data = it.element {
                self.dataSource.append(contentsOf: data)
                
                self.tableView.reloadData()
                self.scrollToBottom()
            }
            }.addDisposableTo(disposeBag)
    }
    
    func scrollToBottom() {
        if  !self.dataSource.isEmpty {
            let lastIndex = IndexPath(item: self.dataSource.count - 1, section: 0)
            tableView.scrollToRow(at: lastIndex, at: UITableViewScrollPosition.bottom, animated: true)
        }
    }
    
    func pullToLoadMore() {
        activityIndicator.isHidden = false
        self.isEndRefreshing = false
        self.activityIndicator.startAnimating()
        
        let backgroundQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
        backgroundQueue.async(execute: {
            self.activityIndicator.stopAnimating()
            self.isReloading = false
            
            sleep(1)
            DispatchQueue.main.async(execute: { () -> Void in
                self.isEndRefreshing = true
                self.activityIndicator.stopAnimating()
                self.isEndRefreshing = true
                self.activityIndicator.isHidden = true
            })
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViews()
        self.bindViewModel()
        self.configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.layoutIfNeeded()
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.showKeyboard(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}




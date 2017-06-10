//
//  ChatsViewController.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/10/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
import SWTableViewCell

protocol ChatBadgeDelegate {
    func onBadge(count:Int)
}

public enum MessagesSectionModel {
    case ReadableMessagesSection(title: String, items: [ChannelSectionItem])
    case UnreadableMessagesSection(title: String, items: [ChannelSectionItem])
}

public extension MessagesSectionModel {
    var title: String {
        switch self {
        case .ReadableMessagesSection(title: let title, items: _):
            return title
        case .UnreadableMessagesSection(title: let title, items: _):
            return title
        }
    }
}

public enum ChannelSectionItem {
    case MessagesSectionItem(item: DB2Channel)
}

extension MessagesSectionModel: SectionModelType {
    public typealias Item = ChannelSectionItem
    
    public var items: [ChannelSectionItem] {
        switch  self {
        case .ReadableMessagesSection(title: _, items: let items):
            return items.map{$0}
        case .UnreadableMessagesSection(title: _, items: let items):
            return items.map{$0}
        }
    }
    
    public init(original: MessagesSectionModel, items: [Item]) {
        switch original {
        case let .ReadableMessagesSection(title: title, items: _):
            self = .ReadableMessagesSection(title: title, items: items)
        case let .UnreadableMessagesSection(title: title, items: _):
            self = .UnreadableMessagesSection(title: title, items: items)
        }
    }
}

class ChatsViewController: UIViewController {
    private let disposeBag = DisposeBag()
    var viewModel: ChatsViewModel!
    var badgeDelegate:ChatBadgeDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: RxTableViewSectionedReloadDataSource<MessagesSectionModel>?
    
    var leftUtilityButtons:NSMutableArray = []
    
    fileprivate func configureView() {
    }
    
    func configureLeftUtilityButtons() {
        let _leftUtilityButtons = NSMutableArray()
        _leftUtilityButtons.sw_addUtilityButton(with: .dbDarkSkyBlue,title: "Remove")
        self.leftUtilityButtons = _leftUtilityButtons
    }
    
    fileprivate func configureTableView() {
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(MessageCell.self)
    }
    
    fileprivate func bindViewModel() {
        assert(viewModel != nil)
        
        let input = ChatsViewModel.Input(
            trigger: Observable.just(),
            driverTrigger: Driver.just(),
            saveTrigger: Driver.just(),
            selection: tableView.rx.itemSelected.asDriver())
        
        let output = viewModel.transform(input: input)
        
        let dataSource = RxTableViewSectionedReloadDataSource<MessagesSectionModel>()
        
        dataSource.configureCell = { dataSource, tableView, indexPath, item in
            switch dataSource[indexPath] {
            case let .MessagesSectionItem(item):
                let cell: MessageCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.updateFromModel(model: item)
                cell.setBadge(count: item.unreadMessagesCount)
                cell.selectionStyle = .none
                self.configureLeftUtilityButtons()
                cell.leftUtilityButtons = self.leftUtilityButtons as! [Any]
                cell.delegate = self
                return cell
            }
        }
        
        output.unreadableMessageCount.subscribe { it in
            if let count = it.element {
                DispatchQueue.main.async {
                    self.badgeDelegate?.onBadge(count: count)
                }
            }
            }.addDisposableTo(disposeBag)
        
        output.sections.bind(to: self.tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(self.disposeBag)
        
        output.selectedChat.drive().addDisposableTo(disposeBag)
        
        tableView.rx.setDelegate(self)
            .addDisposableTo(disposeBag)
        
        self.dataSource = dataSource
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
        self.configureTableView()
        self.configureView()
    }
}

extension ChatsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 10 : 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

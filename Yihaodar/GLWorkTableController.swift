//
//  GLWorkTableController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/1/31.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import XLPagerTabStrip
import CRRefresh
import HGPlaceholders


class PlaceHolderTableView: TableView {
    
    override func customSetup() {
        placeholdersProvider = .default
    }
    
}


/// 待办控制器
class GLDaiBanController: UITableViewController, IndicatorInfoProvider {

    
    var placeholderTableView: PlaceHolderTableView?
    
    private let reusableIdentifier = "DaiBanCellReusableIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placeholderTableView = tableView as? PlaceHolderTableView
        placeholderTableView?.placeholderDelegate = self
    
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reusableIdentifier)
    
//        tableView.cr.addHeadRefresh(animator: FastAnimator()) { [weak self] in
//            /// start refresh
//            /// Do anything you want...
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//                /// Stop refresh when your job finished, it will reset refresh footer if completion is true
//                self?.tableView.cr.endHeaderRefresh()
//            })
//        }
//        /// manual refresh
//        tableView.cr.beginHeaderRefresh()
    }
    
    // MARK: - IndicatorInfoProvider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "代办任务")
    }
}

extension GLDaiBanController: PlaceholderDelegate {
    func view(_ view: Any, actionButtonTappedFor placeholder: Placeholder) {
        print(placeholder.key.value)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier) else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }
    
    
    
}


/// 已完成控制器
class GLWanChengController: UIViewController, IndicatorInfoProvider {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        
        
    }
    
    // MARK: - IndicatorInfoProvider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "已完成任务")
    }
}



// MARK: - 工作台控制器
/// 工作台控制器
class GLWorkTableController: ButtonBarPagerTabStripViewController {
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    
    override func viewDidLoad() {
        
//        edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        
        view.backgroundColor = .cyan
        settings.style.buttonBarBackgroundColor = YiBlueColor
        settings.style.buttonBarItemBackgroundColor = YiBlueColor
        settings.style.selectedBarBackgroundColor = .white
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 16)
        settings.style.selectedBarHeight = 3.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .white
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 1
        settings.style.buttonBarRightContentInset = 1
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = YiUnselectedTitleColor
            newCell?.label.textColor = .white
        }
        
        super.viewDidLoad()
        
        
    }
    
    
    
    /// MARK: - PagerTabStripDataSource
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let daibanVc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLDaiBanController")
        
        return [daibanVc, GLWanChengController()]
    }
    
    
}



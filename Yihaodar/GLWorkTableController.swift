//
//  GLWorkTableController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/1/31.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import XLPagerTabStrip
import CRRefresh


/// 待办控制器
class GLDaiBanController: UITableViewController, IndicatorInfoProvider {
    
    private let reusableIdentifier = "DaiBanCellReusableIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reusableIdentifier)
    
        tableView.cr.addHeadRefresh(animator: FastAnimator()) { [weak self] in
            /// start refresh
            /// Do anything you want...
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                /// Stop refresh when your job finished, it will reset refresh footer if completion is true
                self?.tableView.cr.endHeaderRefresh()
            })
        }
        /// manual refresh
        tableView.cr.beginHeaderRefresh()
        
    }
    
    // MARK: - IndicatorInfoProvider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "代办")
    }
}

extension GLDaiBanController {
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
        return IndicatorInfo(title: "已完成")
    }
}



// MARK: - 工作台控制器
/// 工作台控制器
class GLWorkTableController: ButtonBarPagerTabStripViewController {
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        let naviBarHeight = navigationController?.navigationBar.frame.maxY ?? 0
//        let tabbarHeight = navigationController?.tabBarController?.tabBar.frame.size.height ?? 0
//
//        buttonBarView.frame.origin.y = naviBarHeight
//        containerView.frame = CGRect(x: 0, y: buttonBarView.frame.maxY, width: view.frame.size.width, height: view.frame.size.height - buttonBarView.frame.maxY - tabbarHeight)
    }
    
    override func viewDidLoad() {
        
//        edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        
        settings.style.buttonBarBackgroundColor = .black
        settings.style.buttonBarItemBackgroundColor = UIColor(red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0)
        settings.style.selectedBarBackgroundColor = .blue
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 3.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 1
        settings.style.buttonBarRightContentInset = 1
        
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black
            newCell?.label.textColor = UIColor.red
        }
        
        super.viewDidLoad()
    }
    
    
    /// MARK: - PagerTabStripDataSource
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [GLDaiBanController(), GLWanChengController()]
    }
    
    
}



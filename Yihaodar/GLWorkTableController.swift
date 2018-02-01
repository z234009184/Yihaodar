//
//  GLWorkTableController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/1/31.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import XLPagerTabStrip



/// 待办控制器
class GLDaiBanController: UIViewController, IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "代办")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.red
    }
}


/// 已完成控制器
class GLWanChengController: UIViewController, IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "已完成")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blue
    }
}


/// 工作台控制器
class GLWorkTableController: ButtonBarPagerTabStripViewController {
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let naviBarHeight = navigationController?.navigationBar.frame.maxY ?? 0
        let tabbarHeight = navigationController?.tabBarController?.tabBar.frame.size.height ?? 0
        
        buttonBarView.frame.origin.y = naviBarHeight
        containerView.frame = CGRect(x: 0, y: buttonBarView.frame.maxY, width: view.frame.size.width, height: view.frame.size.height - buttonBarView.frame.maxY - tabbarHeight)
    }
    
    override func viewDidLoad() {
        
        automaticallyAdjustsScrollViewInsets = false
        
        settings.style.buttonBarBackgroundColor = .black
        settings.style.buttonBarItemBackgroundColor = .white
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



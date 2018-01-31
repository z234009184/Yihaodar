//
//  GLWorkTableController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/1/31.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import XLPagerTabStrip

class GLDaiBanController: UIViewController, IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "代办")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.red
    }
}

class GLWanChengController: UIViewController, IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "已完成")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blue
    }
}


class GLWorkTableController: ButtonBarPagerTabStripViewController {
    override func viewDidLoad() {
        self.settings.style.buttonBarItemFont = .systemFont(ofSize: 14)
        self.settings.style.buttonBarItemTitleColor = UIColor.black
        self.settings.style.buttonBarHeight = 40
        self.settings.style.buttonBarBackgroundColor = UIColor.white
        self.settings.style.buttonBarItemBackgroundColor = UIColor.white
        self.settings.style.selectedBarHeight = 2
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black
            newCell?.label.textColor = UIColor.red
        }
        
        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [GLDaiBanController(), GLWanChengController()]
    }
    
    
}



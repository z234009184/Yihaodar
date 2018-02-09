//
//  GLTabbarController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/1/30.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import UIKit



class GLTabBarItem: UITabBarItem {
    override init() {
        super.init()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}


class GLTabBarController: UITabBarController {
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        
        tabBar.isTranslucent = false
        tabBar.backgroundImage = UIImage()
//        tabBar.shadowImage = UIImage()
        tabBar.barTintColor = YiThemeColor
        
    }
    
    
    
    
}





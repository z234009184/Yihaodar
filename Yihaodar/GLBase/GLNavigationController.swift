//
//  GLNavigationController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/1/30.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import UIKit

/// 导航控制器
class GLNavigationController:UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.isTranslucent = false
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.barTintColor = YiThemeColor
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: YiNavigationBarTitleColor]
        
    }
}

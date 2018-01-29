//
//  ViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/1/28.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import UIKit
import React

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsCodeLocation = RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index", fallbackResource: nil)
        let rootView = RCTRootView(bundleURL: jsCodeLocation, moduleName: "Yihaodar", initialProperties: nil, launchOptions: nil)
        view = rootView
        
        
    }
}


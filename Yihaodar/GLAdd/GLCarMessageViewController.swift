//
//  GLCarMessageViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/26.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring

class GLCarMessageViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let backItem = UIBarButtonItem()
        backItem.title = "上一步";
        navigationItem.backBarButtonItem = backItem;
        navigationItem.title = "新建车辆评估"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一步", style: .done, target: self, action: #selector(GLCarMessageViewController.nextBtnClick(item:)))
    }
    
    @objc func nextBtnClick(item: UIBarButtonItem) {
        let vc = UIStoryboard(name: "GLCreateCarEstimate", bundle: Bundle(for: type(of: self))).instantiateViewController(withIdentifier: "GLCarConfigViewController") as! GLCarConfigViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

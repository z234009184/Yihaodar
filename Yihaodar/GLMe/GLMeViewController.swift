//
//  GLMeViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/25.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring
import Toast_Swift

class GLMeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func logoutBtnClick(_ sender: UIButton) {
        self.tabBarController?.dismiss(animated: true, completion: nil)
        
    }
}

class GLMeModifyPassWordViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "修改密码"
        let item = UIBarButtonItem(title: "提交", style: .done, target: self, action: #selector(GLMeModifyPassWordViewController.submitAction(item:)))
        item.tintColor = YiSelectedTitleColor
        navigationItem.rightBarButtonItem = item
    }
    
    @objc func submitAction(item: UIBarButtonItem) {
        
        print("提交")
    }
}

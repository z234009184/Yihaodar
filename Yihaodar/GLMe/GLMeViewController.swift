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
        let str1 = NSMutableAttributedString(string: levelButton.currentTitle!)
        let range1 = NSRange(location: 0, length: str1.length)
        let number = NSNumber(value:NSUnderlineStyle.styleSingle.rawValue)//此处需要转换为NSNumber 不然不对,rawValue转换为integer
        str1.addAttribute(NSAttributedStringKey.underlineStyle, value: number, range: range1)
        str1.addAttribute(NSAttributedStringKey.foregroundColor, value: YiUnselectedTitleColor, range: range1)
        levelButton.setAttributedTitle(str1, for: .normal)
        
        nameLabel.text = GLUser.partyName
    }
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var levelButton: UIButton!
    @IBAction func levelBtnClick(_ sender: UIButton) {
        
        let p = CGPoint(x: view.center.x, y: view.center.y - 100.0)
        view.makeToast(GLUser.organName, point: p, title: nil, image: nil, completion: nil)
        
    }
    @IBAction func logoutBtnClick(_ sender: UIButton) {
        var user = User.read()
        user?.clear()
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

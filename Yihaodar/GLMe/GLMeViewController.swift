//
//  GLMeViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/25.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring
import Toast_Swift
import SwiftyJSON

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
        let arr = GLUser.allOrganName?.split(separator: ",")
        guard let organNames = arr else { return }
        guard organNames.count != 0 else { return }
        var organName = ""
        organNames.enumerated().forEach { (arg) in
            organName.append(String(arg.element))
            organName.append("\n")
        }
        
        view.makeToast(GLUser.allOrganName, point: p, title: nil, image: nil, completion: nil)
        
    }
    @IBAction func logoutBtnClick(_ sender: UIButton) {
        
        GLProvider.request(GLService.logout(partyId: GLUser.partyId!)) { (result) in
            if case let .success(respon) = result {
                let json = JSON(respon.data)
                print(json)
                let user = User.read()
                user?.clear()
                GLUser = User()
                self.tabBarController?.dismiss(animated: true, completion: nil)
            }
        }
        
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
    @IBOutlet weak var passwordField: DesignableTextField!
    
    @IBOutlet weak var comfirmPasswordField: DesignableTextField!
    
    @objc func submitAction(item: UIBarButtonItem) {
        view.endEditing(true)
        if (passwordField.text?.length)! < 1 || (comfirmPasswordField.text?.length)! < 1 {
            view.makeToast("请输入密码")
        }
        
        if passwordField.text != comfirmPasswordField.text {
            view.makeToast("两次密码不一致，请重新输入")
        }
        
        GLProvider.request(GLService.modifyPassword(partyId: GLUser.partyId!, password: passwordField.text!.md5())) {[weak self] (result) in
            if case let .success(respon) = result {
                let json = JSON(respon.data)
                if json["type"] == "S" {
                    self?.view.makeToast("修改成功")
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                        self?.navigationController?.popViewController(animated: true)
                    })
                    
                }
            }
        }
        
        
        print("提交")
    }
}

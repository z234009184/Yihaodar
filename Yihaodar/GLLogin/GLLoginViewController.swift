//
//  GLLoginViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/5.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import UIKit
import TKSubmitTransition
import Spring
import SwiftyJSON
import HandyJSON
import Default

/// 本地用户
var GLUser = User()

///用户模型
struct User: HandyJSON, Codable, DefaultStorable {
    var phoneCode: String?
    var jobName: String?
    var storeId: String?
    var createdDate: String?
    var bossName: String?
    var allOrganName: String?
    var partyTypeId: String?
    var bossId: String?
    var store_permission: String?
    var lastUpdateDateLong: String?
    var emailCode: String?
    var organName: String?
    var orgName: String?
    var jobCode: String?
    var depId: String?
    var depName: String?
    var dimissionDateLong: String?
    var nameLetter: String?
    var createdDateLong: String?
    var partyName: String?
    var partyId: String?
    var lastUpdateDate: String?
    var orgId: String?
    var storeName: String?
    var status: String?
    var comments: String?
    var organCode: String?
    var token: String?
}




class GLLoginViewController: UIViewController {
    
    @IBOutlet weak var logoImgView: DesignableImageView!
    @IBOutlet weak var usernameField: DesignableTextField!
    @IBOutlet weak var passwordField: DesignableTextField!
    @IBOutlet weak var loginBtn: TKTransitionSubmitButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let clearBtn = usernameField.value(forKey: "clearButton") as? UIButton
        clearBtn?.setImage(UIImage(named: "login_clear"), for: .normal)
        clearBtn?.setImage(UIImage(named: "login_clear"), for: .highlighted)
        
        let clearBtnPsd = passwordField.value(forKey: "clearButton") as? UIButton
        clearBtnPsd?.setImage(UIImage(named: "login_clear"), for: .normal)
        clearBtnPsd?.setImage(UIImage(named: "login_clear"), for: .highlighted)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
        if let user = User.read() {
            GLUser = user
            if user.token != nil {
                let rootvc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                guard let vc = rootvc else { return }
                present(vc, animated: false, completion: nil)
            }
        }
    }
    
    @IBAction func loginBtnClick(_ sender: TKTransitionSubmitButton) {
        view.endEditing(true)
        if ((usernameField.text?.length)! < 1) || ((passwordField.text?.length)! < 1) {
            view.makeToast("用户名或密码不能为空")
            return
        }
        
        view.isUserInteractionEnabled = false
        sender.startLoadingAnimation()
        
        GLProvider.request(.login(username: usernameField.text!, password: passwordField.text!.md5())) { [weak self] (result) in
            self?.view.isUserInteractionEnabled = true
            
            if case let .success(response) = result {
                //解析数据
                let json = JSON(response.data)
                print(json)
                if json["type"] == "S" {
                    guard var user = User.deserialize(from: json["results"]["userData"].dictionaryObject) else {
                        return
                    }
                    user.token = json["results"]["token"].stringValue
                    user.write()
                    GLUser = user
                    print(user)
                    
                    sender.startFinishAnimation(0.3, completion: {
                        let rootvc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                        guard let vc = rootvc else { return }
                        self?.present(vc, animated: true, completion: {
                            sender.isEnabled = true
                            sender.returnToOriginalState()
                        })
                        
                    })
                } else {
                    sender.returnToOriginalState()
                }
            }
            
            if case .failure(_) = result {
                sender.returnToOriginalState()
            }
        }
        
        
        
    }
    
    //隐藏状态栏
    override var prefersStatusBarHidden: Bool {
        return true
    }
}


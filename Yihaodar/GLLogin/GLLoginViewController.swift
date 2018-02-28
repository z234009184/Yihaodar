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
            sender.startFinishAnimation(0.3, completion: nil)
            if case let .success(response) = result {
                //解析数据
                let json = JSON(response.data)
                print(json)
            }
            
            
        }
        
        //        sender.animate(0, completion: {[weak self] () -> () in
        //            let rootvc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        //            guard let vc = rootvc else { return }
        //            self?.present(vc, animated: true, completion: {
        //                sender.isEnabled = true
        //            })
        //        })
        
    }
    
    //隐藏状态栏
    override var prefersStatusBarHidden: Bool {
        return true
    }
}


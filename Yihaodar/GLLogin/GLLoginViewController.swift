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

class GLLoginViewController: UIViewController {
    
    @IBOutlet weak var logoImgView: DesignableImageView!
    @IBOutlet weak var usernameField: DesignableTextField!
    @IBOutlet weak var passwordField: DesignableTextField!
    @IBOutlet weak var loginBtn: TKTransitionSubmitButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginBtnClick(_ sender: TKTransitionSubmitButton) {
        sender.isEnabled = false
        
        sender.animate(2, completion: {[weak self] () -> () in
            let rootvc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
            guard let vc = rootvc else { return }
            self?.present(vc, animated: true, completion: nil)
        })
    }
    
    //隐藏状态栏
    override var prefersStatusBarHidden: Bool {
        return true
    }
}


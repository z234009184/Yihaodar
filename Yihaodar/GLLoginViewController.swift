//
//  GLLoginViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/5.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import UIKit
import TKSubmitTransition


class GLLoginViewController: UIViewController {
    
    @IBOutlet weak var loginBtn: TKTransitionSubmitButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginBtnClick(_ sender: TKTransitionSubmitButton) {
        sender.isEnabled = false
        
        sender.animate(1, completion: {[weak self] () -> () in
            let rootvc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
            guard let vc = rootvc else { return }
            self?.present(vc, animated: true, completion: nil)
        })
    }
}


//
//  GLApproveView.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/4/2.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring

class GLApproveView: UIView {
    
    @IBOutlet weak var agreeBtn: UIButton!
    @IBOutlet weak var declineBtn: UIButton!
    var lastBtn: UIButton?
    @IBOutlet weak var remarksTextField: DesignableTextField!
    
    
    var submitClosure: ((_ remarks: String)->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    
    @IBAction func agreeOrDeclineBtnClick(_ sender: UIButton) {
        
        lastBtn?.isSelected = false
        sender.isSelected = true
        lastBtn = sender
    }
    
    /// 提交信息
    @IBAction func submitBtnClick(_ sender: DesignableButton) {
        if let submitClosure = submitClosure {
            submitClosure((remarksTextField.text)!)
        }
        
    }
    
    
}

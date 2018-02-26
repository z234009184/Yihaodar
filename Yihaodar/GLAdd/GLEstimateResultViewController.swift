//
//  GLEstimateResultViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/26.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring

class GLEstimateResultViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "新建车辆评估"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "提交", style: .done, target: self, action: #selector(GLEstimateResultViewController.submitBtnClick(item:)))
    }
    
    @objc func submitBtnClick(item: UIBarButtonItem) {
        
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    
    
    
}

extension GLEstimateResultViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        textViewHeight.constant = textView.contentSize.height
        
    }
    
}


//
//  GLAddView.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/15.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring

class GLAddView: SpringView {
    
    var closeClosure: (()->())?
    var createEstimateClosure: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func createEstimateBtnClick(_ sender: DesignableButton) {
        
        guard let createEstimateClosure = createEstimateClosure else { return }
        createEstimateClosure()
        
    }
    @IBAction func closeBtnClick(_ sender: UIButton) {
        guard let closeClosure = closeClosure else {
            return
        }
        closeClosure()
    }
}

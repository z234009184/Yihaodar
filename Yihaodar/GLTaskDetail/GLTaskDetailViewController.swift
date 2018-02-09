//
//  GLTaskDetailViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/7.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import UIKit
import Spring

class GLTaskDetailViewController: UIViewController {
    
    
    
    /// 报单信息 --------------------
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var orderPersonLabel: UILabel!
    @IBOutlet weak var orderSubmitDateLabel: UILabel!
    @IBOutlet weak var orderCarBrandlabel: UILabel!
    @IBOutlet weak var orderMileageLabel: UILabel!
    @IBOutlet weak var orderBigMoneyLabel: UILabel!
    @IBOutlet weak var orderCarColorLabel: UILabel!
    @IBOutlet weak var orderIsBeiJingNumberLabel: UILabel!
    
    
    /// 评估信息 ---------------------
    @IBOutlet weak var estimateMsgView: DesignableView!
    
    @IBOutlet weak var estimateDateLabel: UILabel!
    @IBOutlet weak var estimatePriceLabel: UILabel!
    @IBOutlet weak var estimateCarDetailMsgLabel: UILabel!
    @IBOutlet weak var estimateMemoLabel: UILabel!
    
    /// 失效视图
    @IBOutlet weak var invalidView: UIView!
    @IBOutlet weak var invalidDateLabel: UILabel!
    
    
    
    /// 底部评估视图
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var estimateButton: DesignableButton!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "任务详情"
    }
    
    
    /// 提交评估
    @IBAction func estimateBtnClick(_ sender: DesignableButton) {
        
    }
    
    
}

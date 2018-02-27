//
//  GLTaskDetailViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/7.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring

class GLTaskDetailBaseViewController: UIViewController {
    
    lazy var tabBarVc = tabBarController as! GLTabBarController
    
    lazy var submitMessageView: GLSubmitMessageView = {
        let accessoryView = GLSubmitMessageView()
        let width = view.bounds.width
        let height = width * 238.0/375.0
        accessoryView.frame.size = CGSize(width: width, height: height)
        accessoryView.frame.origin.x = 0
        
        accessoryView.submitBtnClosure = { [weak self] in
            self?.tabBarVc.dismissCover(btn: nil)
            self?.tabBarVc.showLoadingView(img: #imageLiteral(resourceName: "taskdetail_submit_success"), title: "提交成功")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.5, execute: {
                self?.tabBarVc.dismissCover(btn: nil)
            })
        }
        
        return accessoryView
    }()
    
    func showSubmitMessageView() -> Void {
        let mask = tabBarVc.showMaskView()
        guard let maskView = mask else {
            return
        }
        submitMessageView.frame.origin.y = maskView.frame.size.height
        maskView.addSubview(submitMessageView)
        
        UIView.animate(withDuration: 0.25) {
            self.submitMessageView.frame.origin.y = maskView.frame.size.height - self.submitMessageView.frame.size.height
        }
    }
}



class GLTaskDetailViewController: GLTaskDetailBaseViewController {
    
    var isInvalid: Bool = false
    
    
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
    
    
    @IBOutlet weak var estimateMsgViewTop: NSLayoutConstraint!
    
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
    
    @IBOutlet weak var bottomViewBottom: NSLayoutConstraint!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "任务详情"
        
        
        
        if isInvalid { // 已失效
            bottomViewBottom.constant = bottomView.frame.height - 10
        } else { // 未失效
            estimateMsgViewTop.constant = -(estimateMsgView.frame.height)
        }
        
        
    }
    
    
    /// 提交评估
    @IBAction func estimateBtnClick(_ sender: DesignableButton) {
        showSubmitMessageView()
    }
    
    
}

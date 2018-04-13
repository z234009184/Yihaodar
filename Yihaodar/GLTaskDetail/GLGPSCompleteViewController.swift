//
//  GLGPSCompleteViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/4/3.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring
import RxSwift
import RxCocoa

class GLGPSCompleteViewController: GLTaskDetailBaseViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var stateBtn: UIButton!
    @IBOutlet weak var topViewTopConstraint: NSLayoutConstraint!
    
    var model: GLWorkTableModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskDetailTypeAndStatus()
        
        loadData()
    }
    
    func taskDetailTypeAndStatus() -> Void {
        if model?.statusType == GLWorkTableModel.TaskType.GPS {
            stateBtn.setTitle("已装GPS", for: .normal)
        } else if model?.statusType == GLWorkTableModel.TaskType.underHouse {
            stateBtn.setTitle("已下户", for: .normal)
        } else if model?.statusType == GLWorkTableModel.TaskType.pledge {
            stateBtn.setTitle("已抵质押", for: .normal)
        }
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame.y = topView.frame.maxY + 1
        tableView.frame.height = view.frame.height - topView.frame.maxY - 6
    }
    
    
    
    /// 加载数据 数据驱动
    func loadData() {
        
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let contentOffsetY = scrollView.contentOffset.y
        if contentOffsetY <= 0 {
            topViewTopConstraint.constant = 0
        } else if contentOffsetY > 0 && contentOffsetY <= 65 {
            topViewTopConstraint.constant = -contentOffsetY
        } else {
            topViewTopConstraint.constant = -65
        }
    }
}


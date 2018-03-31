//
//  GLEstimateMessageViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/3/31.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring
import XLPagerTabStrip
import SnapKit
import SwiftyJSON
import HandyJSON


class GLEstimateMessageViewController: UIViewController, IndicatorInfoProvider, UIScrollViewDelegate {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var 车辆配置View: UIView!
    @IBOutlet weak var 评估结果View: UIView!
    @IBOutlet weak var 定价结果View: UIView!
    
    // 车辆配置
    @IBOutlet weak var 变速器Label: UILabel!
    @IBOutlet weak var 驱动方式Label: UILabel!
    @IBOutlet weak var 有无钥匙启动Label: UILabel!
    @IBOutlet weak var 定速巡航Label: UILabel!
    @IBOutlet weak var 导航Label: UILabel!
    @IBOutlet weak var 后排娱乐Label: UILabel!
    @IBOutlet weak var 座椅形式Label: UILabel!
    @IBOutlet weak var 燃油方式Label: UILabel!
    @IBOutlet weak var 天窗Label: UILabel!
    @IBOutlet weak var 空调配置Label: UILabel!
    @IBOutlet weak var 其他Label: UILabel!
    @IBOutlet weak var 事故Label: UILabel!
    
    
    /**
     车况信息动态获取添加
     */
    
    
    // 评估结果
    @IBOutlet weak var 评估师Label: UILabel!
    @IBOutlet weak var 评估价格Label: UILabel!
    @IBOutlet weak var 评估备注Label: UILabel!
    
    
    
    // 定价结果
    @IBOutlet weak var 定价师Label: UILabel!
    @IBOutlet weak var 定价价格Label: UILabel!
    @IBOutlet weak var 定价备注Label: UILabel!
    
    
    var carStateViews = [GLEstimateCarStateView]()
    var carStateDatas = [GLPriceCarStateModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let model = GLBasicMessageViewController.parentVc!.priceDetailModel {
            GLBasicMessageViewController.parentVc!.updateEstimateVcUI(priceDetailModel: model)
        }
        
        
    }
    
    
    
    
    /// 更新界面
    public func updateUI(model: GLPriceDetailModel) {
        if 变速器Label == nil { return }
        
        
        变速器Label.text = model.assessmentList?.gearbox
        驱动方式Label.text = model.assessmentList?.driving_type
        有无钥匙启动Label.text = model.assessmentList?.keyless_startup
        定速巡航Label.text = model.assessmentList?.cruise_control
        导航Label.text = model.assessmentList?.navigation
        后排娱乐Label.text = model.assessmentList?.hpyl
        座椅形式Label.text = model.assessmentList?.chair_type
        燃油方式Label.text = model.assessmentList?.fuel_type
        天窗Label.text = model.assessmentList?.skylight
        空调配置Label.text = model.assessmentList?.air_conditioner
        
        let other = model.assessmentList?.other?.isEmpty == false ? model.assessmentList?.other : "未填写"
        其他Label.text = other
        
        if model.assessmentList?.other?.isEmpty == true {
            其他Label.textColor = YiUnselectedTitleColor
        }
        
        事故Label.text = model.assessmentList?.accident?.isEmpty == false ? model.assessmentList?.accident : "未填写"
        if model.assessmentList?.accident?.isEmpty == true {
            事故Label.textColor = YiUnselectedTitleColor
        }
        
        评估师Label.text = model.assessmentList?.assessment_name
        评估价格Label.text = (model.assessmentList?.confirmed_money)!.decimalString() + "万元"
        if model.assessmentList?.remarks?.isEmpty == false {
            评估备注Label.text = model.assessmentList?.remarks
        } else {
            评估备注Label.text = "未填写"
            评估备注Label.textColor = YiUnselectedTitleColor
        }
        
        
        定价师Label.text = model.priceList?.first?.partyName?.isEmpty == false ? model.priceList?.first?.partyName : "未选择"
        定价价格Label.text = model.priceList?.first?.confirmedMoney?.isEmpty == false ? (model.priceList?.first?.confirmedMoney)!.decimalString() + "万元" : "未选择"
        if model.priceList?.first?.appraiseRemarks?.isEmpty == false {
            定价备注Label.text = model.priceList?.first?.appraiseRemarks
        } else {
            定价备注Label.text = "未填写"
            定价备注Label.textColor = YiUnselectedTitleColor
        }
        
        
        /// 布局 赋值车况信息
        guard let stateArr = model.parts else { return }
        carStateDatas = stateArr
        
        carStateViews.removeAll()
        
        for (index, value) in carStateDatas.enumerated() {
            let carStateView = createCarStateView()
            contentView.addSubview(carStateView)
            carStateViews.append(carStateView)
            
            /// 布局
            if index == 0 {
                carStateView.snp.remakeConstraints { (make) in
                    make.top.equalTo(车辆配置View.snp.bottom).offset(10)
                    make.left.equalTo(contentView).offset(10)
                    make.right.equalTo(contentView).offset(-10)
                    make.height.equalTo(458).priority(249)
                }
            } else {
                let lastCarStateView = carStateViews[index-1]
                carStateView.snp.remakeConstraints { (make) in
                    make.top.equalTo(lastCarStateView.snp.bottom).offset(10)
                    make.left.equalTo(lastCarStateView)
                    make.right.equalTo(lastCarStateView)
                    make.height.equalTo(458).priority(249)
                }
            }
            
            if (index == carStateDatas.count - 1) {
                评估结果View.snp.updateConstraints { (make) in
                    make.top.equalTo(carStateView.snp.bottom).offset(10)
                }
            }
            
            
            // 赋值
            carStateView.partOneLabel.text = value.parts_one_id
            carStateView.partTwoLabel.text = value.parts_two_id
            carStateView.descLabel.text = value.accident_type
            carStateView.remarksLabel.text = value.remarks
        }
        
        
        guard let status_id = model.assessmentList?.status_id else { return }
        if status_id != "03" { // 如果不是已定价 就隐藏定价模块
            定价结果View.snp.remakeConstraints { (make) in
                make.height.equalTo(0)
            }
            定价结果View.isHidden = true
        }
 
    }
    
    
    // IndicatorInfoProvider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "评估信息")
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        
        if contentOffsetY <= 0 {
            GLBasicMessageViewController.parentVc!.topConstraint.constant = 0
        } else if contentOffsetY > 0 && contentOffsetY <= 65 {
            GLBasicMessageViewController.parentVc!.topConstraint.constant = -contentOffsetY
        } else {
            GLBasicMessageViewController.parentVc!.topConstraint.constant = -65
        }
    }
    
}

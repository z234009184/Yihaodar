//
//  GLBasicMessageViewController.swift
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

class GLBasicMessageViewController: UIViewController, IndicatorInfoProvider, UIScrollViewDelegate {
    static var parentVc: GLTaskDetailPriceViewController?
    // 订单信息
    @IBOutlet weak var orderStoreLabel: UILabel!
    @IBOutlet weak var orderManagerLabel: UILabel!
    @IBOutlet weak var orderSuperintendLabel: UILabel!
    @IBOutlet weak var orderMajordomoLabel: UILabel!
    
    
    // 车辆信息
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var carNumberLabel: UILabel!
    
    
    @IBOutlet weak var carBrandLabel: UILabel!
    @IBOutlet weak var carSeriesLabel: UILabel!
    
    @IBOutlet weak var carStyleLabel: UILabel!
    @IBOutlet weak var carColorLabel: UILabel!
    @IBOutlet weak var carProductDateLabel: UILabel!
    @IBOutlet weak var carRegisterDateLabel: UILabel!
    @IBOutlet weak var carMileageLabel: UILabel!
    @IBOutlet weak var carExhaustLabel: UILabel!
    @IBOutlet weak var carPeccancyLabel: UILabel!
    @IBOutlet weak var carEngineVersionLabel: UILabel!
    @IBOutlet weak var carFrameNumberLabel: UILabel!
    @IBOutlet weak var carInvoicePriceLabel: UILabel!
    
    @IBOutlet weak var carChangeMasterTimesLabel: UILabel!
    
    @IBOutlet weak var carCheckLimitDateLabel: UILabel!
    
    @IBOutlet weak var carTrafficLabel: UILabel!
    
    @IBOutlet weak var carBusinessLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GLBasicMessageViewController.parentVc = parent as? GLTaskDetailPriceViewController
        
        
    }
    
    /// 更新界面
    public func updateUI(model: GLPriceDetailModel) {
        orderStoreLabel.text = model.assessmentList?.store_name
        
        if model.assessmentList?.boss_party_id?.isEmpty == false {
            orderManagerLabel.text = model.assessmentList?.boss_party_id
        } else {
            orderManagerLabel.text = "未填写"
            orderManagerLabel.textColor = YiUnselectedTitleColor
        }
        
        if model.assessmentList?.executive_party_id?.isEmpty == false {
            orderSuperintendLabel.text = model.assessmentList?.executive_party_id
        } else {
            orderSuperintendLabel.text = "未填写"
            orderSuperintendLabel.textColor = YiUnselectedTitleColor
        }
        
        if model.assessmentList?.director_party_id?.isEmpty == false {
            orderMajordomoLabel.text = model.assessmentList?.director_party_id
        } else {
            orderMajordomoLabel.text = "未填写"
            orderMajordomoLabel.textColor = YiUnselectedTitleColor
        }
        
        
        
        carNameLabel.text = model.assessmentList?.ower
        carNumberLabel.text = model.assessmentList?.goods_code
        carBrandLabel.text = model.assessmentList?.brand_name
        carSeriesLabel.text = model.assessmentList?.series_name
        carStyleLabel.text = model.assessmentList?.style_name
        carColorLabel.text = model.assessmentList?.car_color
        carProductDateLabel.text = model.assessmentList?.production_date
        carRegisterDateLabel.text = model.assessmentList?.register_date
        carMileageLabel.text = (model.assessmentList?.run_number)! + "万公里"
        carExhaustLabel.text = model.assessmentList?.displacement
        carPeccancyLabel.text = (model.assessmentList?.peccancy)! == "0" ? "无" : "罚分:\(model.assessmentList?.peccancy_fraction ?? "0")(分)  罚款:\(model.assessmentList?.peccancy_money?.decimalString() ?? "0")(元)"
        carEngineVersionLabel.text = model.assessmentList?.engine_code
        carFrameNumberLabel.text = model.assessmentList?.frame_code
        if model.assessmentList?.invoice?.isEmpty == false {
            carInvoicePriceLabel.text = (model.assessmentList?.invoice)!.decimalString() + "万元"
        } else {
            carInvoicePriceLabel.text = "未填写"
            carInvoicePriceLabel.textColor = YiUnselectedTitleColor
        }
        
        if model.assessmentList?.transfer_number?.isEmpty == false {
            carChangeMasterTimesLabel.text = (model.assessmentList?.transfer_number)! + "次"
        } else {
            carChangeMasterTimesLabel.text = "未填写"
            carChangeMasterTimesLabel.textColor = YiUnselectedTitleColor
        }
        
        carCheckLimitDateLabel.text = model.assessmentList?.year_check
        
        
        if model.assessmentList?.jq_insurance?.isEmpty == false {
            carTrafficLabel.text = model.assessmentList?.jq_insurance
        } else {
            carTrafficLabel.text = "未填写"
            carTrafficLabel.textColor = YiUnselectedTitleColor
        }
        
        if model.assessmentList?.sy_insurance?.isEmpty == false {
            carBusinessLabel.text = model.assessmentList?.sy_insurance
        } else {
            carBusinessLabel.text = "未填写"
            carBusinessLabel.textColor = YiUnselectedTitleColor
        }
        
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
    // IndicatorInfoProvider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "基本信息")
    }
}

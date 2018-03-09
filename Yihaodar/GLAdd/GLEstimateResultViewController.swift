//
//  GLEstimateResultViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/26.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring
import HandyJSON



struct GLSubmitModel: HandyJSON {
    
    var partyId = GLUser.partyId
    var store = ""
    var boss_party_id = ""
    var executive_party_id = ""
    var director_party_id = ""
    
    
    var ower = ""
    var goods_code = ""
    var brand_name = ""
    var brand_name_txt = ""
    var goods_series = ""
    var goods_series_txt = ""
    var goods_style = ""
    var goods_style_txt = ""
    var car_color = ""
    var production_date = ""
    var register_date = ""
    var run_number = ""
    var displacement = ""
    var peccancy = ""
    var peccancy_fraction = ""
    var peccancy_money = ""
    var engine_code = ""
    var frame_code = ""
    var invoice = ""
    var transfer_number = ""
    var year_check = ""
    var jq_insurance = ""
    var sy_insurance = ""
    var insurance_due_date: String?
    
    var gearbox = ""
    var driving_type = ""
    var keyless_startup = ""
    var cruise_control = ""
    var navigation = ""
    var hpyl = ""
    var chair_type = ""
    var fuel_type = ""
    var skylight = ""
    var air_conditioner = ""
    var other = ""
    var airbag = ""
    var accident = ""
    var accident_level = ""
    
    var ccrpList = [GLCcrpModel]()
    var ccroList = [GLCcroModel]()
}

struct GLCcrpModel: HandyJSON {
    var id: String?
    var cust_request_id: String?
    var parts_one_id = ""
    var parts_two_id = ""
    var accident_type = ""
    var remarks: String?
}




class GLEstimateResultViewController: UIViewController {
    
    
    static var summitModel = GLSubmitModel()
    
    
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


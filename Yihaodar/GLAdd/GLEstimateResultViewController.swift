//
//  GLEstimateResultViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/26.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring
import HandyJSON
import IQKeyboardManagerSwift
import SwiftyJSON



struct GLSubmitModel: HandyJSON {
    
    var partyId = GLUser.partyId!
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
    var insurance_due_date = ""
    
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
    
    var assessment_name = GLUser.partyId!
    var confirmed_money = ""
    var remarks = ""
}






class GLEstimateResultViewController: UIViewController {
    
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var priceTextField: DesignableTextField!
    @IBOutlet weak var remarksTextView: IQTextView!
    static var summitModel = GLSubmitModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "新建车辆评估"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "提交", style: .done, target: self, action: #selector(GLEstimateResultViewController.submitBtnClick(item:)))
    }
    
    @objc func submitBtnClick(item: UIBarButtonItem) {
        view.endEditing(true)
        if priceTextField.text?.isEmpty == true {
            view.makeToast("请输入评估价格")
            return
        }
        
        GLEstimateResultViewController.summitModel.confirmed_money = priceTextField.text ?? "0"
        GLEstimateResultViewController.summitModel.remarks = remarksTextView.text
        
        let model = GLEstimateResultViewController.summitModel
        let ccrpList = model.ccrpList.toJSON().flatMap { (dict) -> [String: Any]? in
            return dict
        }
        let ccroList = model.ccroList.toJSON().flatMap { (dict) -> [String: Any]? in
            return dict
        }
        
        
        
        let tabBarVc = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController as? GLTabBarController
        tabBarVc?.showLoadingView(img: #imageLiteral(resourceName: "taskdetail_submit_loading"), title: "提交中...")
        GLProvider.request(GLService.submitCreateCarEstimateWithMsg(partyId: model.partyId, store: model.store, boss_party_id: model.boss_party_id, executive_party_id: model.executive_party_id, director_party_id: model.director_party_id, ower: model.ower, goods_code: model.goods_code, brand_name: model.brand_name, brand_name_txt: model.brand_name_txt, goods_series: model.goods_series, goods_series_txt: model.goods_series_txt, goods_style: model.goods_style, goods_style_txt: model.goods_series_txt, car_color: model.car_color, production_date: model.production_date, register_date: model.register_date, run_number: model.run_number, displacement: model.displacement, peccancy: model.peccancy, peccancy_fraction: model.peccancy_fraction, peccancy_money: model.peccancy_money, engine_code: model.engine_code, frame_code: model.frame_code, invoice: model.invoice, transfer_number: model.transfer_number, year_check: model.year_check, insurance_due_date: model.insurance_due_date, jq_insurance: model.jq_insurance, sy_insurance: model.sy_insurance, gearbox: model.gearbox, driving_type: model.driving_type, keyless_startup: model.keyless_startup, cruise_control: model.cruise_control, navigation: model.navigation, hpyl: model.hpyl, chair_type: model.chair_type, fuel_type: model.fuel_type, skylight: model.skylight, air_conditioner: model.air_conditioner, other: model.other, airbag: model.airbag, accident: model.accident, accident_level: model.accident_level, ccrpList: ccrpList, ccroList: ccroList, assessment_name: model.assessment_name, confirmed_money: model.confirmed_money, remarks: model.remarks)) { [weak self] (result) in
            
            if case let .success(respon) = result {
                print(JSON(respon.data))
                let jsonStr = JSON(respon.data)
                if jsonStr["type"] == "S" {
                    tabBarVc?.showLoadingView(img: #imageLiteral(resourceName: "taskdetail_submit_success"), title: "提交成功")
                    NotificationCenter.default.post(name: YiSubmitSuccessNotificationName, object: nil)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                        tabBarVc?.dismissCover(btn: nil)
                        self?.navigationController?.dismiss(animated: true, completion: nil)
                    })
                } else {
                    tabBarVc?.showLoadingView(img: #imageLiteral(resourceName: "taskdetail_submit_failure"), title: "提交失败")
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                        tabBarVc?.dismissCover(btn: nil)
                    })
                }
                
                
            }
            
            if case .failure(_) = result {
                tabBarVc?.dismissCover(btn: nil)
            }
            
        }
        
        
        
        
        
    }
    
    
}

extension GLEstimateResultViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        print(textField.text as Any, string)
        if textField != priceTextField {
            return true
        }
        
        
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        print(newString)
        let expression = "^[0-9]{0,20}((\\.)[0-9]{0,2})?$"
        let regex = try! NSRegularExpression(pattern: expression, options: NSRegularExpression.Options.allowCommentsAndWhitespace)
        let numberOfMatches = regex.numberOfMatches(in: newString, options:NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, (newString as NSString).length))
        
        return numberOfMatches != 0
        
    }
}


extension GLEstimateResultViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        textViewHeight.constant = textView.contentSize.height
        
    }
}


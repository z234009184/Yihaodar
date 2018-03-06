//
//  GLCarMessageViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/26.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring

class GLCarMessageViewController: UIViewController {
    /// 车主姓名Field
    @IBOutlet weak var nameField: DesignableTextField!
    /// 车牌号码
    @IBOutlet weak var carNumberLabel: DesignableTextField!
    /// 车辆品牌
    @IBOutlet weak var carBrandLabel: UILabel!
    /// 车辆系列
    @IBOutlet weak var carSeriesLabel: UILabel!
    /// 车辆型号
    @IBOutlet weak var carVersionLabel: UILabel!
    /// 车辆颜色
    @IBOutlet weak var carColorLabel: DesignableTextField!
    /// 出厂日期
    @IBOutlet weak var carProductDateLabel: UILabel!
    /// 登记日期
    @IBOutlet weak var carRegisterDateLabel: UILabel!
    /// 行驶里程
    @IBOutlet weak var carDriverMileageField: DesignableTextField!
    /// 排气量
    @IBOutlet weak var carExhaustField: DesignableTextField!
    /// 是否违章开关
    @IBOutlet weak var carPeccancySwitch: UISwitch!
   
    /// 是否罚分Field
    @IBOutlet weak var carPunishScoreField: DesignableTextField!
   
    /// 是否罚款Field
    @IBOutlet weak var carPunishMoneyField: DesignableTextField!
    /// 发动机引擎号码Field
    @IBOutlet weak var carEngineNumberField: DesignableTextField!
    /// 车架号
    @IBOutlet weak var carFrameNumberField: DesignableTextField!
    
    /// 开票价格Field
    @IBOutlet weak var carInvoicePriceField: DesignableTextField!
   
    /// 过户次数Field
    @IBOutlet weak var carTransferTimesField: DesignableTextField!
    /// 年检到期日
    @IBOutlet weak var carYearlyInspectionDateLabel: UILabel!
    @IBOutlet weak var openOrFoldBtn: UIButton!
    
    /// 交强险Label
    @IBOutlet weak var carTrafficInsuranceLabel: UILabel!
    
    /// 商业险Label
    @IBOutlet weak var carBusinessInsuranceLabel: UILabel!
    
    
    @IBOutlet var switchViews: [UIView]!
    
    @IBOutlet var switchHeights: [NSLayoutConstraint]!
    
    
    @IBOutlet var constraintsViews: [UIView]!
    
    @IBOutlet var contraints: [NSLayoutConstraint]!
    
    
    var selectedBrandModel: GLRadioModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backItem = UIBarButtonItem()
        backItem.title = "上一步";
        navigationItem.backBarButtonItem = backItem;
        navigationItem.title = "新建车辆评估"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一步", style: .done, target: self, action: #selector(GLCarMessageViewController.nextBtnClick(item:)))
        carPeccancySwitch.isOn = false
        peccancySwitch(carPeccancySwitch)
        openOrFoldBtnClick(openOrFoldBtn)
    }
    
    
    @objc func nextBtnClick(item: UIBarButtonItem) {
        
        guard nameField.text?.isEmpty == false else {
            view.makeToast("车主姓名为空")
            return
        }
        
        guard carNumberLabel.text?.isEmpty == false else {
            view.makeToast("车牌号为空")
            return
        }
        
        
        
        let vc = UIStoryboard(name: "GLCreateCarEstimate", bundle: Bundle(for: type(of: self))).instantiateViewController(withIdentifier: "GLCarConfigViewController") as! GLCarConfigViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 车辆品牌
    @IBAction func carbrandBtnClick(_ sender: UIButton) {
        /// 处理数据
        let dataArr = GLCreateCarEstimateViewController.model?.brandList.map({ [weak self] (brandModel) -> GLRadioModel in
            let radioModel = GLRadioModel(id: brandModel.brandId, title: brandModel.brandName, subTitle: nil, isSelected: self?.selectedBrandModel?.id == brandModel.brandId ? true : false, isTextFied: false, input: nil, inputPlaceHolder: nil)
            return radioModel
        })
        guard let dataArray = dataArr else { return }
        
        let radioVc = GLRadioViewController.jumpRadioVc(title: "选择客户经理", dataArray: dataArray, navigationVc: navigationController)
        radioVc.closeClosure = { [weak self] (model: GLRadioModel) in
            self?.selectedBrandModel = model
            self?.carBrandLabel.text = model.title
        }
    }
    
    /// 车辆系列
    @IBAction func carSeriesBtnClick(_ sender: UIButton) {
        
    }
    
    /// 车辆型号
    @IBAction func carVersionBtnClick(_ sender: UIButton) {
        
    }
    
    
    @IBAction func carProductDateSelected(_ sender: UIButton) {
        GLDatePicker.showDatePicker(currentDate: Date()) { (date) in
            print(date)
        }
        
    }
    
    @IBAction func carRegisterDateSelected(_ sender: UIButton) {
        GLDatePicker.showDatePicker(currentDate: Date()) { (date) in
            print(date)
        }
        
    }
    
    @IBAction func carYearCheckDateSelected(_ sender: UIButton) {
        GLDatePicker.showDatePicker(currentDate: Date()) { (date) in
            print(date)
        }
        
    }
    
    
    @IBAction func carTrafficDateSelected(_ sender: UIButton) {
        GLDatePicker.showDatePicker(currentDate: Date()) { (date) in
            print(date)
        }
        
    }
    
    
    @IBAction func carBusinessDateSelected(_ sender: UIButton) {
        GLDatePicker.showDatePicker(currentDate: Date()) { (date) in
            print(date)
        }
        
    }
    
    
    
    @IBAction func openOrFoldBtnClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true {
            contraints.enumerated().forEach({ (index, obj) in
                obj.constant = 70
            })
            constraintsViews.enumerated().forEach({ (index, obj) in
                obj.isHidden = false
            })
            
        } else {
            contraints.enumerated().forEach({ (index, obj) in
                obj.constant = 0
            })
            constraintsViews.enumerated().forEach({ (index, obj) in
                obj.isHidden = true
            })
        }
        
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func peccancySwitch(_ sender: UISwitch) {
        if sender.isOn == true {
            switchViews.enumerated().forEach({ (index, obj) in
                obj.isHidden = false
            })
            switchHeights.enumerated().forEach({ (index, obj) in
                obj.constant = 44
            })
        } else {
            switchViews.enumerated().forEach({ (index, obj) in
                obj.isHidden = true
            })
            switchHeights.enumerated().forEach({ (index, obj) in
                obj.constant = 0
            })
        }
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
}

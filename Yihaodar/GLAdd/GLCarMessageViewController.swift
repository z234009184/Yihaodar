//
//  GLCarMessageViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/26.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring
import SwiftyJSON

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
    var selectedSeriesModel: GLRadioModel?
    var selectedStyleModel: GLRadioModel?
    
    
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
        /*
        guard nameField.text?.isEmpty == false else {
            view.makeToast("车主姓名为空")
            return
        }
        
        guard carNumberLabel.text?.isEmpty == false else {
            view.makeToast("车牌号为空")
            return
        }
 
 
        guard selectedBrandModel != nil else {
            view.makeToast("请选择车辆品牌")
            return
        }
 
        
        guard selectedSeriesModel != nil else {
            view.makeToast("请选择车辆系列")
            return
        }
        
        guard selectedStyleModel != nil else {
            view.makeToast("请选择车辆型号")
            return
        }
        
        guard carColorLabel.text?.isEmpty == false else {
            view.makeToast("请输入车辆颜色")
            return
        }
        
        guard carProductDateLabel.text != "请选择" else {
            view.makeToast("请选择出厂日期")
            return
        }
        
        guard carRegisterDateLabel.text != "请选择" else {
            view.makeToast("请选择登记日期")
            return
        }
        
        guard carDriverMileageField.text?.isEmpty == false else {
            view.makeToast("请输入行驶里程数")
            return
        }
        
        guard carExhaustField.text?.isEmpty == false else {
            view.makeToast("请输入排气量")
            return
        }
        
        if carPeccancySwitch.isOn == true {
            if carPunishScoreField.text?.isEmpty == true {
                view.makeToast("请输入罚分")
                return
            }
            if carPunishMoneyField.text?.isEmpty == true {
                view.makeToast("请输入罚款")
                return
            }
        }
        
        guard carEngineNumberField.text?.isEmpty == false else {
            view.makeToast("请输入发动机型号")
            return
        }
        
        guard carFrameNumberField.text?.isEmpty == false else {
            view.makeToast("请输入车架号")
            return
        }
        
        guard carYearlyInspectionDateLabel.text != "请选择" else {
            view.makeToast("请选择年检到期日")
            return
        }
        */
        
        
        /// 存入提交模型中
        GLEstimateResultViewController.summitModel.ower = nameField.text ?? ""
        GLEstimateResultViewController.summitModel.goods_code = carNumberLabel.text ?? ""
        GLEstimateResultViewController.summitModel.brand_name = selectedBrandModel?.id ?? ""
        GLEstimateResultViewController.summitModel.brand_name_txt = selectedBrandModel?.title ?? ""
        GLEstimateResultViewController.summitModel.goods_series = selectedSeriesModel?.id ?? ""
        GLEstimateResultViewController.summitModel.goods_series_txt = selectedSeriesModel?.title ?? ""
        GLEstimateResultViewController.summitModel.goods_style = selectedStyleModel?.id ?? ""
        GLEstimateResultViewController.summitModel.goods_style_txt = selectedStyleModel?.title ?? ""
        GLEstimateResultViewController.summitModel.car_color = carColorLabel.text ?? ""
        
        GLEstimateResultViewController.summitModel.production_date = carProductDateLabel.text ?? ""
        GLEstimateResultViewController.summitModel.register_date = carRegisterDateLabel.text ?? ""
        GLEstimateResultViewController.summitModel.run_number = carDriverMileageField.text ?? ""
        GLEstimateResultViewController.summitModel.displacement = carExhaustField.text ?? ""
        GLEstimateResultViewController.summitModel.peccancy = carPeccancySwitch.isOn == false ? "0" : "1"
        GLEstimateResultViewController.summitModel.peccancy_fraction = carPunishScoreField.text ?? ""
        GLEstimateResultViewController.summitModel.peccancy_money = carPunishMoneyField.text ?? ""
        GLEstimateResultViewController.summitModel.engine_code = carEngineNumberField.text ?? ""
        GLEstimateResultViewController.summitModel.frame_code = carFrameNumberField.text ?? ""
        GLEstimateResultViewController.summitModel.invoice = carInvoicePriceField.text ?? ""
        GLEstimateResultViewController.summitModel.transfer_number = carTransferTimesField.text ?? ""
        GLEstimateResultViewController.summitModel.year_check = carYearlyInspectionDateLabel.text ?? ""
        GLEstimateResultViewController.summitModel.jq_insurance = carTrafficInsuranceLabel.text ?? ""
        GLEstimateResultViewController.summitModel.sy_insurance = carBusinessInsuranceLabel.text ?? ""
        GLEstimateResultViewController.summitModel.insurance_due_date = ""
        
        
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
        
        let radioVc = GLRadioViewController.jumpRadioVc(title: "选择车辆品牌", dataArray: dataArray, navigationVc: navigationController)
        radioVc.closeClosure = { [weak self] (model: GLRadioModel) in
            self?.selectedBrandModel = model
            self?.carBrandLabel.text = model.title
            self?.loadCarSeriesData()
        }
    }
    
    /// 车辆系列
    @IBAction func carSeriesBtnClick(_ sender: UIButton) {
        guard selectedBrandModel != nil else {
            view.makeToast("请选择车辆品牌")
            return
        }
        
        /// 处理数据
        let dataArr = GLCreateCarEstimateViewController.model?.brandSeriesList.map({ [weak self] (brandSeries) -> GLRadioModel in
            let radioModel = GLRadioModel(id: brandSeries.seriesId, title: brandSeries.seriesName, subTitle: nil, isSelected: self?.selectedSeriesModel?.id == brandSeries.seriesId ? true : false, isTextFied: false, input: nil, inputPlaceHolder: nil)
            return radioModel
        })
        guard let dataArray = dataArr else { return }
        
        let radioVc = GLRadioViewController.jumpRadioVc(title: "选择车辆系列", dataArray: dataArray, navigationVc: navigationController)
        radioVc.closeClosure = { [weak self] (model: GLRadioModel) in
            self?.selectedSeriesModel = model
            self?.carSeriesLabel.text = model.title
            self?.loadCarStyleData()
        }
        
    }

    
    /// 车辆型号
    @IBAction func carVersionBtnClick(_ sender: UIButton) {
        guard selectedSeriesModel != nil else {
            view.makeToast("请选择车辆系列")
            return
        }
        
        /// 处理数据
        let dataArr = GLCreateCarEstimateViewController.model?.carStyleList.map({ [weak self] (styleModel) -> GLRadioModel in
            let radioModel = GLRadioModel(id: styleModel.id, title: styleModel.value, subTitle: nil, isSelected: self?.selectedStyleModel?.id == styleModel.id ? true : false, isTextFied: false, input: nil, inputPlaceHolder: nil)
            return radioModel
        })
        guard let dataArray = dataArr else { return }
        
        let radioVc = GLRadioViewController.jumpRadioVc(title: "选择车辆型号", dataArray: dataArray, navigationVc: navigationController)
        radioVc.closeClosure = { [weak self] (model: GLRadioModel) in
            self?.selectedStyleModel = model
            self?.carVersionLabel.text = model.title
        }
    }
    
    
    @IBAction func carProductDateSelected(_ sender: UIButton) {
        GLDatePicker.showDatePicker(currentDate: Date()) { [weak self] (date) in
            self?.carProductDateLabel.text = date
        }
    }
    
    @IBAction func carRegisterDateSelected(_ sender: UIButton) {
        GLDatePicker.showDatePicker(currentDate: Date()) { [weak self] (date) in
            self?.carRegisterDateLabel.text = date
        }
        
    }
    
    @IBAction func carYearCheckDateSelected(_ sender: UIButton) {
        GLDatePicker.showDatePicker(currentDate: Date()) { [weak self] (date) in
            self?.carYearlyInspectionDateLabel.text = date
        }
        
    }
    
    
    @IBAction func carTrafficDateSelected(_ sender: UIButton) {
        GLDatePicker.showDatePicker(currentDate: Date()) { [weak self] (date) in
            self?.carTrafficInsuranceLabel.text = date
        }
        
    }
    
    
    @IBAction func carBusinessDateSelected(_ sender: UIButton) {
        GLDatePicker.showDatePicker(currentDate: Date()) { [weak self] (date) in
            self?.carBusinessInsuranceLabel.text = date
        }
    }
    
    /// 加载车辆系列
    func loadCarSeriesData() -> Void {
        guard let brandId = selectedBrandModel?.id else {
            view.makeToast("品牌ID为空")
            return
        }
        
        navigationController?.view.showLoading()
        GLProvider.request(GLService.getCarSeries(brandId: brandId)) { [weak self] (result) in
            if case let .success(respon) = result {
                let jsonStr = JSON(respon.data)
                print(jsonStr)
                GLCreateCarEstimateViewController.model?.brandSeriesList = [GLCarSeriesModel].deserialize(from: jsonStr.rawString(), designatedPath: "results.brandSeriesList") as! [GLCarSeriesModel]
                
            }
            self?.navigationController?.view.hideLoading()
        }
    }
    
    /// 加载车辆型号
    func loadCarStyleData() -> Void {
        guard let seriesId = selectedSeriesModel?.id else {
            view.makeToast("系列ID为空")
            return
        }
        
        navigationController?.view.showLoading()
        GLProvider.request(GLService.getCarVersion(seriesId: seriesId)) { [weak self] (result) in
            if case let .success(respon) = result {
                let jsonStr = JSON(respon.data)
                print(jsonStr)
                GLCreateCarEstimateViewController.model?.carStyleList = [GLCarStyleModel].deserialize(from: jsonStr.rawString(), designatedPath: "results.carStyleList") as! [GLCarStyleModel]
                
            }
            self?.navigationController?.view.hideLoading()
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

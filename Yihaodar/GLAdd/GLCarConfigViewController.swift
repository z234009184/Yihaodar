//
//  GLCarStateViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/26.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring

class GLCarConfigViewController: UIViewController {
    
    @IBOutlet weak var gearboxLabel: UILabel!
    @IBOutlet weak var drivingTypeLabel: UILabel!
    @IBOutlet weak var keylessStartupLabel: UILabel!
    @IBOutlet weak var cruiseControlLabel: UILabel!
    @IBOutlet weak var navigationLabel: UILabel!
    @IBOutlet weak var hpylLabel: UILabel!
    @IBOutlet weak var seatFormatLabel: UILabel!
    @IBOutlet weak var fuelTypeLabel: UILabel!
    @IBOutlet weak var skylightLabel: UILabel!
    @IBOutlet weak var airConditionerLabel: UILabel!
    @IBOutlet weak var otherLabel: UILabel!
    @IBOutlet weak var accidentLabel: UILabel!
    
    @IBOutlet weak var openOrFoldBtn: UIButton!
    @IBOutlet var optionViews: [UIView]!
    @IBOutlet var optionViewsHeight: [NSLayoutConstraint]!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        openOrFoldBtnClick(openOrFoldBtn)
        
        let backItem = UIBarButtonItem()
        backItem.title = "上一步";
        navigationItem.backBarButtonItem = backItem;
        navigationItem.title = "新建车辆评估"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一步", style: .done, target: self, action: #selector(GLCarConfigViewController.nextBtnClick(item:)))
    }
    
    
    @objc func nextBtnClick(item: UIBarButtonItem) {
        
        if gearboxLabel.text == "请选择" || gearboxLabel.text?.isEmpty == true {
            view.makeToast("请选择变速器")
            return
        }
        if drivingTypeLabel.text == "请选择" || drivingTypeLabel.text?.isEmpty == true {
            view.makeToast("请选择驱动方式")
            return
        }
        if keylessStartupLabel.text == "请选择" || keylessStartupLabel.text?.isEmpty == true {
            view.makeToast("请选择有无钥匙启动")
            return
        }
        if cruiseControlLabel.text == "请选择" || cruiseControlLabel.text?.isEmpty == true {
            view.makeToast("请选择定速巡航")
            return
        }
        if navigationLabel.text == "请选择" || navigationLabel.text?.isEmpty == true {
            view.makeToast("请选择导航")
            return
        }
        if hpylLabel.text == "请选择" || hpylLabel.text?.isEmpty == true {
            view.makeToast("请选择后排娱乐")
            return
        }
        if seatFormatLabel.text == "请选择" || seatFormatLabel.text?.isEmpty == true {
            view.makeToast("请选择座椅形式")
            return
        }
        if fuelTypeLabel.text == "请选择" || fuelTypeLabel.text?.isEmpty == true {
            view.makeToast("请选择燃油方式")
            return
        }
        if skylightLabel.text == "请选择" || skylightLabel.text?.isEmpty == true {
            view.makeToast("请选择天窗")
            return
        }
        if airConditionerLabel.text == "请选择" || airConditionerLabel.text?.isEmpty == true {
            view.makeToast("请选择空调配置")
            return
        }
 
        
        /// 存入提交模型中
        GLEstimateResultViewController.summitModel.gearbox = gearboxLabel.text ?? ""
        GLEstimateResultViewController.summitModel.driving_type = drivingTypeLabel.text ?? ""
        GLEstimateResultViewController.summitModel.keyless_startup = keylessStartupLabel.text ?? ""
        GLEstimateResultViewController.summitModel.cruise_control = cruiseControlLabel.text ?? ""
        GLEstimateResultViewController.summitModel.navigation = navigationLabel.text ?? ""
        GLEstimateResultViewController.summitModel.hpyl = hpylLabel.text ?? ""
        GLEstimateResultViewController.summitModel.chair_type = seatFormatLabel.text ?? ""
        GLEstimateResultViewController.summitModel.fuel_type = fuelTypeLabel.text ?? ""
        GLEstimateResultViewController.summitModel.skylight = skylightLabel.text ?? ""
        GLEstimateResultViewController.summitModel.air_conditioner = airConditionerLabel.text ?? ""
        GLEstimateResultViewController.summitModel.other = otherLabel.text != "请选择" ? otherLabel.text! : ""
        GLEstimateResultViewController.summitModel.accident = accidentLabel.text != "请选择" ? accidentLabel.text! : ""
        
        selectedOtherModels?.forEach({ (radioModel) in
            if radioModel.isTextFied {
                GLEstimateResultViewController.summitModel.airbag =  radioModel.input ?? ""
            }
        })
        
        selectedAccidentModels?.forEach({ (radioModel) in
            if radioModel.isTextFied {
                GLEstimateResultViewController.summitModel.accident_level = radioModel.input ?? ""
            }
        })
        
        
        
        let vc = UIStoryboard(name: "GLCreateCarEstimate", bundle: Bundle(for: type(of: self))).instantiateViewController(withIdentifier: "GLCarStateViewController") as! GLCarStateViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    
    
    var selectedGearboxModel: GLRadioModel?
    @IBAction func gearboxAction(_ sender: UIButton) { // 单选
        // 加载数据
        let path = Bundle.main.path(forResource: "biansuqi", ofType: "plist")
        guard let filePath = path else { return }
        let arr = NSArray(contentsOfFile: filePath) as? [Any]
        // 字典数组 转模型数组
        guard var dataArray = [GLRadioModel].deserialize(from: arr) as? [GLRadioModel] else { return }
        if let selectedGearboxModel = selectedGearboxModel {
            dataArray = dataArray.map({ (radioModel) -> GLRadioModel in
                var radioModel = radioModel
                if selectedGearboxModel.id == radioModel.id {
                    radioModel = selectedGearboxModel
                }
                return radioModel
            })
        }
        let radioVc = GLRadioViewController.jumpRadioVc(title: "选择变速器", dataArray: dataArray, navigationVc: navigationController)
        radioVc.closeClosure = { [weak self] (radioModel) in
            self?.selectedGearboxModel = radioModel
            self?.gearboxLabel.text = radioModel.title
        }
    }
    
    var selectedDrivingTypeModel: GLRadioModel?
    @IBAction func drivingTypeAction(_ sender: UIButton) {
        // 加载数据
        let path = Bundle.main.path(forResource: "qudongfangshi", ofType: "plist")
        guard let filePath = path else { return }
        let arr = NSArray(contentsOfFile: filePath) as? [Any]
        // 字典数组 转模型数组
        guard var dataArray = [GLRadioModel].deserialize(from: arr) as? [GLRadioModel] else { return }
        if let selectedDrivingTypeModel = selectedDrivingTypeModel {
            dataArray = dataArray.map({ (radioModel) -> GLRadioModel in
                var radioModel = radioModel
                if selectedDrivingTypeModel.id == radioModel.id {
                    radioModel = selectedDrivingTypeModel
                }
                return radioModel
            })
        }
        let radioVc = GLRadioViewController.jumpRadioVc(title: "选择驱动方式", dataArray: dataArray, navigationVc: navigationController)
        radioVc.closeClosure = { [weak self] (radioModel) in
            self?.selectedDrivingTypeModel = radioModel
            self?.drivingTypeLabel.text = radioModel.title
        }
    }
    
    var selectedKeylessModel: GLRadioModel?
    @IBAction func keylessStartupAction(_ sender: UIButton) {
        // 加载数据
        let path = Bundle.main.path(forResource: "youwu", ofType: "plist")
        guard let filePath = path else { return }
        let arr = NSArray(contentsOfFile: filePath) as? [Any]
        // 字典数组 转模型数组
        guard var dataArray = [GLRadioModel].deserialize(from: arr) as? [GLRadioModel] else { return }
        if let selectedKeylessModel = selectedKeylessModel {
            dataArray = dataArray.map({ (radioModel) -> GLRadioModel in
                var radioModel = radioModel
                if selectedKeylessModel.id == radioModel.id {
                    radioModel = selectedKeylessModel
                }
                return radioModel
            })
        }
        let radioVc = GLRadioViewController.jumpRadioVc(title: "选择有无钥匙启动", dataArray: dataArray, navigationVc: navigationController)
        radioVc.closeClosure = { [weak self] (radioModel) in
            self?.selectedKeylessModel = radioModel
            self?.keylessStartupLabel.text = radioModel.title
        }
    }
    
    var selectedCruiseControlModel: GLRadioModel?
    @IBAction func cruiseControlAction(_ sender: UIButton) {
        // 加载数据
        let path = Bundle.main.path(forResource: "youwu", ofType: "plist")
        guard let filePath = path else { return }
        let arr = NSArray(contentsOfFile: filePath) as? [Any]
        // 字典数组 转模型数组
        guard var dataArray = [GLRadioModel].deserialize(from: arr) as? [GLRadioModel] else { return }
        if let selectedCruiseControlModel = selectedCruiseControlModel {
            dataArray = dataArray.map({ (radioModel) -> GLRadioModel in
                var radioModel = radioModel
                if selectedCruiseControlModel.id == radioModel.id {
                    radioModel = selectedCruiseControlModel
                }
                return radioModel
            })
        }
        let radioVc = GLRadioViewController.jumpRadioVc(title: "选择定速巡航", dataArray: dataArray, navigationVc: navigationController)
        radioVc.closeClosure = { [weak self] (radioModel) in
            self?.selectedCruiseControlModel = radioModel
            self?.cruiseControlLabel.text = radioModel.title
        }
    }
    
    var selectedNavigationModel: GLRadioModel?
    @IBAction func navigationAction(_ sender: UIButton) {
        // 加载数据
        let path = Bundle.main.path(forResource: "youwu", ofType: "plist")
        guard let filePath = path else { return }
        let arr = NSArray(contentsOfFile: filePath) as? [Any]
        // 字典数组 转模型数组
        guard var dataArray = [GLRadioModel].deserialize(from: arr) as? [GLRadioModel] else { return }
        if let selectedNavigationModel = selectedNavigationModel {
            dataArray = dataArray.map({ (radioModel) -> GLRadioModel in
                var radioModel = radioModel
                if selectedNavigationModel.id == radioModel.id {
                    radioModel = selectedNavigationModel
                }
                return radioModel
            })
        }
        let radioVc = GLRadioViewController.jumpRadioVc(title: "选择导航", dataArray: dataArray, navigationVc: navigationController)
        radioVc.closeClosure = { [weak self] (radioModel) in
            self?.selectedNavigationModel = radioModel
            self?.navigationLabel.text = radioModel.title
        }
    }
    
    var selectedHpylModel: GLRadioModel?
    @IBAction func hpylAction(_ sender: UIButton) {
        // 加载数据
        let path = Bundle.main.path(forResource: "youwu", ofType: "plist")
        guard let filePath = path else { return }
        let arr = NSArray(contentsOfFile: filePath) as? [Any]
        // 字典数组 转模型数组
        guard var dataArray = [GLRadioModel].deserialize(from: arr) as? [GLRadioModel] else { return }
        if let selectedHpylModel = selectedHpylModel {
            dataArray = dataArray.map({ (radioModel) -> GLRadioModel in
                var radioModel = radioModel
                if selectedHpylModel.id == radioModel.id {
                    radioModel = selectedHpylModel
                }
                return radioModel
            })
        }
        let radioVc = GLRadioViewController.jumpRadioVc(title: "选择后排娱乐", dataArray: dataArray, navigationVc: navigationController)
        radioVc.closeClosure = { [weak self] (radioModel) in
            self?.selectedHpylModel = radioModel
            self?.hpylLabel.text = radioModel.title
        }
        
    }
    
    
    var selectSeatFormatModels: [GLRadioModel]?
    @IBAction func carSeatFormatAction(_ sender: UIButton) {
        
        // 加载数据
        let path = Bundle.main.path(forResource: "zuoyixingshi", ofType: "plist")
        guard let filePath = path else { return }
        let arr = NSArray(contentsOfFile: filePath) as? [Any]
        // 字典数组 转模型数组
        guard var dataArray = [GLRadioModel].deserialize(from: arr) as? [GLRadioModel] else { return }
        if let selectSeatFormatModels = selectSeatFormatModels {
            dataArray = dataArray.map({ (radioModel) -> GLRadioModel in
                var radioModel = radioModel
                for value in selectSeatFormatModels {
                    if value.id == radioModel.id {
                        radioModel = value
                    }
                }
                return radioModel
            })
        }
        
        let multiVc = GLCheckBoxViewController.jumpMultiVc(title: "选择座椅形式", dataArray: dataArray, navigationVc: navigationController)
        multiVc.closeClosure = { [weak self] (arr) in
            self?.selectSeatFormatModels = arr
            self?.seatFormatLabel.text = arr.reduce("", { (result, radioModel) -> String in
                let title = radioModel.title ?? ""
                let input = radioModel.input ?? ""
                let str = result.isEmpty ? "" : "、"
                return result + str + title + input
            })
        }
    }
    
    
    var selectedFuelTypeModels: [GLRadioModel]?
    @IBAction func fuelTypeAction(_ sender: UIButton) {
        // 加载数据
        let path = Bundle.main.path(forResource: "ranyoufangshi", ofType: "plist")
        guard let filePath = path else { return }
        let arr = NSArray(contentsOfFile: filePath) as? [Any]
        // 字典数组 转模型数组
        guard var dataArray = [GLRadioModel].deserialize(from: arr) as? [GLRadioModel] else { return }
        if let selectedFuelTypeModels = selectedFuelTypeModels {
            dataArray = dataArray.map({ (radioModel) -> GLRadioModel in
                var radioModel = radioModel
                for value in selectedFuelTypeModels {
                    if value.id == radioModel.id {
                        radioModel = value
                    }
                }
                return radioModel
            })
        }
        
        let multiVc = GLCheckBoxViewController.jumpMultiVc(title: "选择燃油方式", dataArray: dataArray, navigationVc: navigationController)
        multiVc.closeClosure = { [weak self] (arr) in
            self?.selectedFuelTypeModels = arr
            self?.fuelTypeLabel.text = arr.reduce("", { (result, radioModel) -> String in
                let title = radioModel.title ?? ""
                let input = radioModel.input ?? ""
                let str = result.isEmpty ? "" : "、"
                return result + str + title + input
            })
        }
        
    }
    
    var selectedSkylightModel: GLRadioModel?
    @IBAction func skylightAction(_ sender: UIButton) {
        // 加载数据
        let path = Bundle.main.path(forResource: "tianchuang", ofType: "plist")
        guard let filePath = path else { return }
        let arr = NSArray(contentsOfFile: filePath) as? [Any]
        // 字典数组 转模型数组
        guard var dataArray = [GLRadioModel].deserialize(from: arr) as? [GLRadioModel] else { return }
        if let selectedSkylightModel = selectedSkylightModel {
            dataArray = dataArray.map({ (radioModel) -> GLRadioModel in
                var radioModel = radioModel
                if selectedSkylightModel.id == radioModel.id {
                    radioModel = selectedSkylightModel
                }
                return radioModel
            })
        }
        let radioVc = GLRadioViewController.jumpRadioVc(title: "选择天窗", dataArray: dataArray, navigationVc: navigationController)
        radioVc.closeClosure = { [weak self] (radioModel) in
            self?.selectedSkylightModel = radioModel
            self?.skylightLabel.text = radioModel.title
        }
    }
    
    
    var selectedAirConditionerModels: [GLRadioModel]?
    @IBAction func airConditionerAction(_ sender: UIButton) {
        // 加载数据
        let path = Bundle.main.path(forResource: "kongtiaopeizhi", ofType: "plist")
        guard let filePath = path else { return }
        let arr = NSArray(contentsOfFile: filePath) as? [Any]
        // 字典数组 转模型数组
        guard var dataArray = [GLRadioModel].deserialize(from: arr) as? [GLRadioModel] else { return }
        if let selectedAirConditionerModels = selectedAirConditionerModels {
            dataArray = dataArray.map({ (radioModel) -> GLRadioModel in
                var radioModel = radioModel
                for value in selectedAirConditionerModels {
                    if value.id == radioModel.id {
                        radioModel = value
                    }
                }
                return radioModel
            })
        }
        
        let multiVc = GLCheckBoxViewController.jumpMultiVc(title: "选择空调配置", dataArray: dataArray, navigationVc: navigationController)
        multiVc.closeClosure = { [weak self] (arr) in
            self?.selectedAirConditionerModels = arr
            self?.airConditionerLabel.text = arr.reduce("", { (result, radioModel) -> String in
                let title = radioModel.title ?? ""
                let input = radioModel.input ?? ""
                let str = result.isEmpty ? "" : "、"
                return result + str + title + input
            })
        }
    }
    
    
    var selectedOtherModels: [GLRadioModel]?
    @IBAction func otherAction(_ sender: UIButton) {
        // 加载数据
        let path = Bundle.main.path(forResource: "qita", ofType: "plist")
        guard let filePath = path else { return }
        let arr = NSArray(contentsOfFile: filePath) as? [Any]
        // 字典数组 转模型数组
        guard var dataArray = [GLRadioModel].deserialize(from: arr) as? [GLRadioModel] else { return }
        if let selectedOtherModels = selectedOtherModels {
            dataArray = dataArray.map({ (radioModel) -> GLRadioModel in
                var radioModel = radioModel
                for value in selectedOtherModels {
                    if value.id == radioModel.id {
                        radioModel = value
                    }
                }
                return radioModel
            })
        }
        
        let multiVc = GLCheckBoxViewController.jumpMultiVc(title: "选择其他", dataArray: dataArray, navigationVc: navigationController)
        multiVc.closeClosure = { [weak self] (arr) in
            self?.selectedOtherModels = arr
            self?.otherLabel.text = arr.reduce("", { (result, radioModel) -> String in
                let title = radioModel.title ?? ""
                let input = (radioModel.input != nil) ? (radioModel.input)! + "个" : ""
                let str = result.isEmpty ? "" : "、"
                return result + str + title + input
            })
        }
        
    }
    
    
    var selectedAccidentModels: [GLRadioModel]?
    @IBAction func accidentAction(_ sender: UIButton) {
        // 加载数据
        let path = Bundle.main.path(forResource: "shigu", ofType: "plist")
        guard let filePath = path else { return }
        let arr = NSArray(contentsOfFile: filePath) as? [Any]
        // 字典数组 转模型数组
        guard var dataArray = [GLRadioModel].deserialize(from: arr) as? [GLRadioModel] else { return }
        if let selectedAccidentModels = selectedAccidentModels {
            dataArray = dataArray.map({ (radioModel) -> GLRadioModel in
                var radioModel = radioModel
                for value in selectedAccidentModels {
                    if value.id == radioModel.id {
                        radioModel = value
                    }
                }
                return radioModel
            })
        }
        
        let multiVc = GLCheckBoxViewController.jumpMultiVc(title: "选择事故", dataArray: dataArray, navigationVc: navigationController)
        multiVc.closeClosure = { [weak self] (arr) in
            self?.selectedAccidentModels = arr
            self?.accidentLabel.text = arr.reduce("", { (result, radioModel) -> String in
                let title = radioModel.title ?? ""
                let input = radioModel.input ?? ""
                let str = result.isEmpty ? "" : "、"
                return result + str + title + input
            })
        }
    }
    
    /// 展开/折叠
    @IBAction func openOrFoldBtnClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true {
            optionViewsHeight.forEach({ (obj) in
                obj.constant = 70
            })
            optionViews.forEach({ (obj) in
                obj.isHidden = false
            })
            
        } else {
            optionViewsHeight.forEach({ (obj) in
                obj.constant = 0
            })
            optionViews.forEach({ (obj) in
                obj.isHidden = true
            })
        }
        
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
        
    }
}

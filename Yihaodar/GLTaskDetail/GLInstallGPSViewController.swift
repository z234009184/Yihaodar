//
//  GLInstallGPSViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/3/28.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring
import SnapKit
import SwiftyJSON
import HandyJSON


struct GLGPSManListModel: HandyJSON {
    /*
     {
     "partyId": "00201801121627055342",
     "partyName": "GPS安装负责人",
     "organName": "海淀门店-德胜门店",
     "jobName": "装GPS",
     "allOrganName": "总裁办,海淀门店-德胜门店"
     },
     */
    
    var partyId = ""
    var partyName = ""
    var organName = ""
    var jobName = ""
    var allOrganName = ""
    
    
}



/// 安装GPS控制器
class GLInstallGPSViewController: UIViewController {
    /// 内容View
    @IBOutlet weak var contentView: UIView!
    
    
    /// 顶部整体View（包括安装人员 安装信息）
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var installerLabel: UILabel!
    
    @IBOutlet weak var installDateLabel: UILabel!
    
    
    /// 添加安装描述按钮
    @IBOutlet weak var addInstallMsgBtn: UIButton!
    
    
    private lazy var arr = [GLInstallDetailView]()
    
    private var gpsManList: [GLGPSManListModel]?
    
    var gpsInfoModel: GLGPSInfoModel?
    
    
    var model: GLWorkTableModel?
    var submitSuccess: (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkBackGPSProcess()
    }
    
    /// 查询回退流程
    func checkBackGPSProcess() {
        view.showLoading()
        GLProvider.request(GLService.backGPSProcess(l_number: (model?.executionId)!), completion: { [weak self] (result) in
            self?.view.hideLoading()
            if case let .success(respon) = result {
                let json = JSON(respon.data)
                print(json)
                if json["type"] == "S" {
                    self?.gpsInfoModel = GLGPSInfoModel.deserialize(from: json.rawString(), designatedPath: "results.GpsList")
                    
                    if let gpsInfoModel = self?.gpsInfoModel {
                        self?.updateUI(gpsInfoModel: gpsInfoModel)
                    }
                }
            }
        })
        
    }
    
    func updateUI(gpsInfoModel: GLGPSInfoModel) -> Void {
        var r1 = GLRadioModel()
        r1.title = gpsInfoModel.g_personnel
        selectedInstallerModel = r1
        
        installDateLabel.text = gpsInfoModel.install_Date
        
        gpsInfoModel.gpsSet.enumerated().forEach { [weak self] (index, gpsSetModel) in
            let installDetailView = self?.createInstallDetailView()
            
            var r2 = GLRadioModel()
            r2.title = gpsSetModel.gps_type
            installDetailView?.selectedDeviceTypeModel = r2
            
            installDetailView?.deviceVersionTextView.text = gpsSetModel.gps_version
            installDetailView?.deviceNumberTextView.text = gpsSetModel.gps_number
            installDetailView?.deviceSIMNumberTextView.text = gpsSetModel.gps_sim_card
            installDetailView?.installLocationTextView.text = gpsSetModel.gps_position
            installDetailView?.remarksTextView.text = gpsSetModel.gps_remark
            
        }
        
        layoutAddInstallDetailViews(array: arr)
        
    }
    
    
    
    /// 取消
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    /// 提交
    @IBAction func submitAction(_ sender: UIBarButtonItem) {
        
        // 过滤判断
        if self.selectedInstallerModel == nil {
            view.makeToast("请选择安装人员")
            return
        }
        
        if self.installDateLabel.text == "请选择" {
            view.makeToast("请选择安装日期")
            return
        }
        
        
        var gpsList = [GLGPSInfoModel.GLGPSSetModel]()
        // 过滤并赋值
        for item in arr {
            if item.deviceTypeLabel.text == "请选择" {
                view.makeToast("请选择设备类型")
                return
            }
            
            if item.deviceVersionTextView.text.isEmpty == true {
                view.makeToast("请输入设备型号")
                return
            }
            
            if item.deviceNumberTextView.text.isEmpty == true {
                view.makeToast("请输入设备编号")
                return
            }
            
            if item.deviceSIMNumberTextView.text.isEmpty == true {
                view.makeToast("请输入设备SIM卡号")
                return
            }
            
            if item.installLocationTextView.text.isEmpty == true {
                view.makeToast("请输入安装位置")
                return
            }
            
            let gpsSetModel = GLGPSInfoModel.GLGPSSetModel(gps_type: (item.selectedDeviceTypeModel?.title)!, gps_version: item.deviceVersionTextView.text, gps_number: item.deviceNumberTextView.text, gps_position: item.installLocationTextView.text, gps_sim_card: item.deviceSIMNumberTextView.text, gps_remark: item.remarksTextView.text)
            gpsList.append(gpsSetModel)
        }
        
        
        
        let listDic = gpsList.toJSON() as! [[String: Any]]
        
        var backFlag = "0"
        if gpsInfoModel != nil { // 有回退流程
            backFlag = "1"
        }
        
        let tabBarVc = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController as? GLTabBarController
        GLProvider.request(GLService.submitGPSInfo(partyId: GLUser.partyId!, processExampleId: (model?.processId)!, processTaskId: (model?.processTaskId)!, backFlag: backFlag, l_id: (model?.executionId)!, l_number: (model?.executionId)!, g_personnel: (selectedInstallerModel?.title)!, install_Date: (installDateLabel.text)!, gpsList: listDic)) { [weak self] (result) in
            if case let .success(respon) = result {
                let json = JSON(respon.data)
                print(json)
                if json["type"] == "S" {
                    tabBarVc?.showLoadingView(img: #imageLiteral(resourceName: "taskdetail_submit_success"), title: "提交成功")
                    NotificationCenter.default.post(name: YiRefreshNotificationName, object: nil)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                        tabBarVc?.dismissCover(btn: nil)
                        self?.navigationController?.dismiss(animated: false, completion: {
                            if let submitSuccess = self?.submitSuccess {
                                submitSuccess()
                            }
                        })
                    })
                } else {
                    tabBarVc?.showLoadingView(img: #imageLiteral(resourceName: "taskdetail_submit_failure"), title: "提交失败")
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                        tabBarVc?.dismissCover(btn: nil)
                    })
                }
            }
        }
    }
    
    
    var selectedInstallerModel: GLRadioModel? {
        didSet {
            installerLabel.text = selectedInstallerModel?.title
        }
    }
    /// 选择安装人员
    @IBAction func selectedInstallerAction(_ sender: UIButton) {
        loadGPSManListData { [weak self] (dataArray) in
            
            /// 处理数据
            let dataArr = dataArray.map({ [weak self] (installerModel) -> GLRadioModel in
                let radioModel = GLRadioModel(id: installerModel.partyId, title: installerModel.partyName, subTitle: installerModel.allOrganName, isSelected: self?.selectedInstallerModel?.id == installerModel.partyId ? true : false, isTextFied: false, input: nil, inputPlaceHolder: nil)
                return radioModel
            })
            
            
            let radioVc = GLRadioViewController.jumpRadioVc(title: "选择车辆型号", dataArray: dataArr, navigationVc: self?.navigationController)
            
            radioVc.closeClosure = { [weak self] (model: GLRadioModel) in
                self?.selectedInstallerModel = model
            }
        }
    }
    
    /// 加载安装人员数据
    func loadGPSManListData(success:((_ dataArray: [GLGPSManListModel])->())?) -> Void {
        if let gpsManList = gpsManList {
            if let success = success {
                success(gpsManList)
                return
            }
        }
        
        view.showLoading()
        GLProvider.request(GLService.getGPSManagersInfo(partyId: GLUser.partyId!)) { [weak self] (result) in
            self?.view.hideLoading()
            if case let .success(respon) = result {
                let json = JSON(respon.data)
                if json["type"] == "S" {
                    
                    self?.gpsManList = [GLGPSManListModel].deserialize(from: json.rawString(), designatedPath: "results.gpsManList") as? [GLGPSManListModel]
                    
                    if let gpsManlist = self?.gpsManList {
                        if let success = success {
                            success(gpsManlist)
                        }
                    }
                }
            }
            
        }
        
        
    }
    
    
    
    /// 选择安装日期
    @IBAction func selectedInstallDateAction(_ sender: UIButton) {
        GLDatePicker.showDatePicker(currentDate: Date()) { [weak self] (date) in
            self?.installDateLabel.text = date
        }
        view.endEditing(true)
    }
    
    
    /// 添加安装描述
    @IBAction func addInstallMsgBtnAction(_ sender: UIButton) {
        // 添加安装描述
        _ = createInstallDetailView()
        
        // 布局视图
        layoutAddInstallDetailViews(array: arr)
    }
    
    // 创建安装描述
    func createInstallDetailView() -> GLInstallDetailView {
        let installDetailView = Bundle.main.loadNibNamed("GLInstallDetailView", owner: nil, options: nil)?.first as! GLInstallDetailView
        contentView.addSubview(installDetailView)
        
        weak var weakInstallDetailView = installDetailView
        // 设备类型选择
        installDetailView.deviceTypeClosure = { [weak self] in
            
            // 加载数据
            let path = Bundle.main.path(forResource: "GPStype", ofType: "plist")
            guard let filePath = path else { return }
            let arr = NSArray(contentsOfFile: filePath) as? [Any]
            // 字典数组 转模型数组
            guard var dataArray = [GLRadioModel].deserialize(from: arr) as? [GLRadioModel] else { return }
            if let selectedDeviceTypeModel = weakInstallDetailView?.selectedDeviceTypeModel {
                dataArray = dataArray.map({ (radioModel) -> GLRadioModel in
                    var radioModel = radioModel
                    if selectedDeviceTypeModel.id == radioModel.id {
                        radioModel = selectedDeviceTypeModel
                    }
                    return radioModel
                })
            }
            
            let radioVc = GLRadioViewController.jumpRadioVc(title: "选择设备类型", dataArray: dataArray, navigationVc: self?.navigationController)
            radioVc.closeClosure = { (radioModel) in
                weakInstallDetailView?.selectedDeviceTypeModel = radioModel
            }
            
        }
        
        
        
        
        
        /// 删除
        installDetailView.deleteClosure = { [weak self] in
            guard let weakInstallDetailView = weakInstallDetailView else { return }
            let index = self?.arr.index(of: weakInstallDetailView)
            guard let i = index else { return }
            self?.arr.remove(at: i)
            weakInstallDetailView.removeFromSuperview()
            if let firstView = self?.arr.first {
                firstView.snp.remakeConstraints { (make) in
                    make.top.equalTo((self?.topView)!.snp.bottom).offset(10)
                    make.left.equalTo((self?.topView)!)
                    make.right.equalTo((self?.topView)!)
                }
            }
            if let lastView = self?.arr.last {
                self?.addInstallMsgBtn.snp.remakeConstraints { (make) in
                    make.top.equalTo(lastView.snp.bottom).offset(40)
                }
            } else {
                self?.addInstallMsgBtn.snp.removeConstraints()
            }
            UIView.animate(withDuration: 0.25, animations: {
                self?.view.layoutIfNeeded()
            })
        }
        
        /// 添加到数组中
        arr.append(installDetailView)
        
        return installDetailView
    }
    
    
    
    /// 布局视图
    func layoutAddInstallDetailViews(array: [GLInstallDetailView]) {
        
        if array.count == 0 { return }
        
        for (index, installDetailView) in array.enumerated() {
            if index == 0 {
                installDetailView.snp.remakeConstraints { (make) in
                    make.top.equalTo(topView.snp.bottom).offset(10)
                    make.left.equalTo(topView)
                    make.right.equalTo(topView)
                }
            } else {
                let lastView = array[index - 1]
                installDetailView.snp.remakeConstraints { (make) in
                    make.top.equalTo(lastView.snp.bottom).offset(10)
                    make.left.equalTo(topView)
                    make.right.equalTo(topView)
                }
            }
        }
        
        if let lastView = array.last {
            addInstallMsgBtn.snp.remakeConstraints { (make) in
                make.top.equalTo(lastView.snp.bottom).offset(40)
            }
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
        })
        
    }
    
}

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// 取消
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    /// 提交
    @IBAction func submitAction(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
    var selectedInstallerModel: GLRadioModel?
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
                self?.installerLabel.text = model.title
            }
        }
    }
    
    /// 加载安装人员数据
    func loadGPSManListData(success:((_ dataArray: [GLGPSManListModel])->())?) -> Void {
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
        let installDetailView = Bundle.main.loadNibNamed("GLInstallDetailView", owner: nil, options: nil)?.first as! GLInstallDetailView
        contentView.addSubview(installDetailView)
        
        /// 布局
        installDetailView.snp.remakeConstraints { (make) in
            if let lastView = arr.last {
                make.top.equalTo(lastView.snp.bottom).offset(10)
            } else {
                make.top.equalTo(topView.snp.bottom).offset(10)
            }
            make.left.equalTo(topView)
            make.right.equalTo(topView)
        }
        
        addInstallMsgBtn.snp.remakeConstraints { (make) in
            make.top.equalTo(installDetailView.snp.bottom).offset(40)
        }
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
        })
        
        weak var weakInstallDetailView = installDetailView
        
        
        
        
        /// 添加到数组中
        arr.append(installDetailView)
        
        
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
        
    }
    
    
}

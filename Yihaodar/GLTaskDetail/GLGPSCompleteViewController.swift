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
import SwiftyJSON
import HandyJSON


struct GLCompleteModel: HandyJSON {
    var gps = GLGPSInfomationModel()
    var pauperJson = GLPauperJsonModel()
    var pledge = GLPledgeModel()
    
    
    struct GLGPSInfomationModel: HandyJSON {
        var gpsInformation = GLGPSInfoModel()
    }
    
    struct GLPauperJsonModel: HandyJSON {
        var processPauper = GLPauperInfoModel()
    }
    
    struct GLPledgeModel: HandyJSON {
        var processPledge = GLPledgeInfoModel()
        
        
        struct GLPledgeInfoModel: HandyJSON {
            /// 抵质押登记日期
            var crea_date = ""
            var attachmentList = [GLPauperInfoModel.GLAttachmentModel]()
        }
    }
    
}



class GLGPSCompleteViewController: GLTaskDetailBaseViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var stateBtn: UIButton!
    @IBOutlet weak var topViewTopConstraint: NSLayoutConstraint!
    
    var model: GLWorkTableModel?
    
    var completeModel: GLCompleteModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "任务详情"
        
        
        tableView.snp.remakeConstraints { (make) in
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.top.equalTo(topView.snp.bottom).offset(1)
            make.bottom.equalTo(view)
        }
        
        
        taskDetailTypeAndStatus()
        
    }
    
    
    
    
    func taskDetailTypeAndStatus() -> Void {
        titleLabel.text = model?.executionId
        subTitleLabel.text = model?.store_name
        
        stateBtn.backgroundColor = .white
        stateBtn.setTitleColor(YiBlueColor, for: .normal)
        
        if model?.statusType == GLWorkTableModel.TaskType.GPS {
            stateBtn.setTitle("已装GPS", for: .normal)
            loadInstalledGPSData()
        } else if model?.statusType == GLWorkTableModel.TaskType.underHouse {
            stateBtn.setTitle("已下户", for: .normal)
            loadPauperData()
        } else if model?.statusType == GLWorkTableModel.TaskType.pledge {
            stateBtn.setTitle("已抵质押", for: .normal)
            loadPledgeData()
        }
    }
    
    
    
    
    /// 加载已安装GPS数据 数据驱动
    func loadInstalledGPSData() {
        view.showLoading()
        GLProvider.request(GLService.getInstalledGPSInfo(processTaskId: (model?.processTaskId)!)) { [weak self] (result) in
            self?.view.hideLoading()
            if case let .success(respon) = result {
                let json = JSON(respon.data)
                
                self?.completeModel = GLCompleteModel.deserialize(from: json.rawString(), designatedPath: "results")
                
                if let gpsModel = self?.completeModel?.gps.gpsInformation {
                    self?.dataArray = GLModelConvert.installedGPSInfoData(model: gpsModel)
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    /// 加载下户数据 数据驱动
    func loadPauperData() {
        view.showLoading()
        GLProvider.request(GLService.getPauperEndInfo(processTaskId: (model?.processTaskId)!, l_number: (model?.executionId)!)) { [weak self] (result) in
            self?.view.hideLoading()
            if case let .success(respon) = result {
                let json = JSON(respon.data)
                print(json)
                self?.completeModel = GLCompleteModel.deserialize(from: json.rawString(), designatedPath: "results")
                
                if let pauperModel = self?.completeModel?.pauperJson.processPauper {
                    self?.dataArray = GLModelConvert.pauperInfoData(model: pauperModel)
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    
    /// 加载已抵质押数据 数据驱动
    func loadPledgeData() {
        view.showLoading()
        GLProvider.request(GLService.getPledgeEndInfo(partyId: GLUser.partyId!, processTaskId: (model?.processTaskId)!, l_number: (model?.executionId)!)) { [weak self] (result) in
            self?.view.hideLoading()
            if case let .success(respon) = result {
                let json = JSON(respon.data)
                print(json)
                self?.completeModel = GLCompleteModel.deserialize(from: json.rawString(), designatedPath: "results")

                if let pledgeModel = self?.completeModel?.pledge.processPledge {
                    self?.dataArray = GLModelConvert.pledgeInfoData(model: pledgeModel)
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let contentOffsetY = scrollView.contentOffset.y
        if contentOffsetY <= 0 {
//            if topViewTopConstraint.constant != 0 {
                topViewTopConstraint.constant = 0
//            }
        } else if contentOffsetY > 0 && contentOffsetY <= 65 {
//            if topViewTopConstraint.constant != 0 {
                topViewTopConstraint.constant = -contentOffsetY
//            }
        } else {
//            if topViewTopConstraint.constant != -65 {
                topViewTopConstraint.constant = -65
//            }
        }
    }
}


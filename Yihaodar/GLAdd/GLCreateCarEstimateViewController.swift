//
//  GLCreateCarEstimateViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/16.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring
import HandyJSON
import SwiftyJSON

/// 门店
struct GLStoreModel: HandyJSON {
    var storeName: String = ""
    var status: String = ""
    var storeId: String = ""
    var createdDateLong: String = ""
    var createdDate: String = ""
    var lastUpdateDateLong: String = ""
    var lastUpdateDate: String = ""
    var orgId: String = ""
}

/// 客户经理
struct GLBossModel: HandyJSON {
    var partyId: String = ""
    var partyName: String = ""
    var jobName: String = ""
    var organName: String = ""
}

/// 团队主管
struct GLExecutivModel: HandyJSON {
    var partyId: String = ""
    var partyName: String = ""
    var jobName: String = ""
    var organName: String = ""
}

/// 业务总监
struct GLDirectorModel: HandyJSON {
    var partyId: String = ""
    var partyName: String = ""
    var jobName: String = ""
    var organName: String = ""
}

/// 车辆品牌
struct GLCarBrandModel: HandyJSON {
    var brandId: String = ""
    var brandName: String = ""
}

/// 车构件
struct GLCarPartsModel: HandyJSON {
    var id: String = ""
    var value: String = ""
    var dname: String = ""
}


/// 描述
struct GLCarTPartsModel: HandyJSON {
    var id: String = ""
    var value: String = ""
    var dname: String = ""
}



struct GLCreateDataModel: HandyJSON {
    var storeList: [GLStoreModel] = []
    var bossList: [GLBossModel] = []
    var executiveList: [GLExecutivModel] = []
    var directorList: [GLDirectorModel] = []
    var brandList: [GLCarBrandModel] = []
    var partsList: [GLCarPartsModel] = []
    var tpartsList: [GLCarTPartsModel] = []
}







/// 订单信息控制器
class GLCreateCarEstimateViewController: UIViewController {
    
    @IBOutlet weak var foldHeight1: NSLayoutConstraint!
    @IBOutlet weak var foldHeight2: NSLayoutConstraint!
    @IBOutlet weak var foldHeight3: NSLayoutConstraint!
    let cellFoldHeight: CGFloat = 0.0
    let cellOpenHeight: CGFloat = 70.0
    @IBOutlet weak var cell1: UIView!
    @IBOutlet weak var cell2: UIView!
    @IBOutlet weak var cell3: UIView!
    @IBOutlet weak var switchBtn: UIButton!
    
    
    
    
    var selectedMendianModel: GLRadioModel?
    var selectedBossModel: GLRadioModel?
    var selectedExecutiveModel: GLRadioModel? // 主管
    var selectedDirectorModel: GLRadioModel?
    
    
    static var model: GLCreateDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 收起可选项
        openOrFoldBtnClick(switchBtn)
        
        let backItem = UIBarButtonItem()
        backItem.title = "上一步";
        navigationItem.backBarButtonItem = backItem;
        
        loadData()
    }
    
    
    func loadData() -> Void {
        navigationController?.view.showLoading()
        GLProvider.request(GLService.getCarOtherInfo(partyId: GLUser.partyId!)) { [weak self] (result) in
            if case let .success(respon) = result {
                let jsonStr = JSON(respon.data)
                print(jsonStr)
                GLCreateCarEstimateViewController.model = GLCreateDataModel.deserialize(from: jsonStr.rawString(), designatedPath: "results")
                
            }
            self?.navigationController?.view.hideLoading()
        }
    }
    
    @IBAction func cancelBtnClick(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextBtnClick(_ sender: UIBarButtonItem) {
        
        guard selectedMendianModel != nil else {
            view.makeToast("请选择所属门店")
            return
        }
        
        let vc = UIStoryboard(name: "GLCreateCarEstimate", bundle: Bundle(for: type(of: self))).instantiateViewController(withIdentifier: "GLCarMessageViewController") as! GLCarMessageViewController
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBOutlet weak var 门店Label: UILabel!
    @IBAction func mendianBtnClick(_ sender: UIButton) {
        /// 处理数据
        let dataArr = GLCreateCarEstimateViewController.model?.storeList.map({ [weak self] (storeModel) -> GLRadioModel in
            let radioModel = GLRadioModel(id: storeModel.storeId, title: storeModel.storeName, subTitle: nil, isSelected: self?.selectedMendianModel?.id == storeModel.storeId ? true : false, isTextFied: false, input: nil, inputPlaceHolder: nil)
            return radioModel
        })
        guard let dataArray = dataArr else { return }
        
        let radioVc = GLRadioViewController.jumpRadioVc(title: "选择所属门店", dataArray: dataArray, navigationVc: navigationController)
        radioVc.closeClosure = { [weak self] (model: GLRadioModel) in
            self?.selectedMendianModel = model
            self?.门店Label.text = model.title
        }
    }
    
    
    @IBOutlet weak var 经理Label: UILabel!
    @IBAction func jingliBtnClick(_ sender: UIButton) {
        /// 处理数据
        let dataArr = GLCreateCarEstimateViewController.model?.bossList.map({ [weak self] (bossModel) -> GLRadioModel in
            let radioModel = GLRadioModel(id: bossModel.partyId, title: bossModel.partyName, subTitle: bossModel.jobName + bossModel.organName, isSelected: self?.selectedBossModel?.id == bossModel.partyId ? true : false, isTextFied: false, input: nil, inputPlaceHolder: nil)
            return radioModel
        })
        guard let dataArray = dataArr else { return }
        
        let radioVc = GLRadioViewController.jumpRadioVc(title: "选择客户经理", dataArray: dataArray, navigationVc: navigationController)
        radioVc.closeClosure = { [weak self] (model: GLRadioModel) in
            self?.selectedBossModel = model
            self?.经理Label.text = model.title
        }
    }
    
    @IBOutlet weak var 主管Label: UILabel!
    @IBAction func zhuguanBtnClick(_ sender: UIButton) {
        /// 处理数据
        let dataArr = GLCreateCarEstimateViewController.model?.executiveList.map({ [weak self] (executiveModel) -> GLRadioModel in
            let radioModel = GLRadioModel(id: executiveModel.partyId, title: executiveModel.partyName, subTitle: executiveModel.jobName + executiveModel.organName, isSelected: self?.selectedExecutiveModel?.id == executiveModel.partyId ? true : false, isTextFied: false, input: nil, inputPlaceHolder: nil)
            return radioModel
        })
        guard let dataArray = dataArr else { return }
        
        let radioVc = GLRadioViewController.jumpRadioVc(title: "选择客户经理", dataArray: dataArray, navigationVc: navigationController)
        radioVc.closeClosure = { [weak self] (model: GLRadioModel) in
            self?.selectedExecutiveModel = model
            self?.主管Label.text = model.title
        }
    }
    
    @IBOutlet weak var 总监Label: UILabel!
    @IBAction func zongjianBtnClick(_ sender: UIButton) {
        /// 处理数据
        let dataArr = GLCreateCarEstimateViewController.model?.directorList.map({ [weak self] (directorModel) -> GLRadioModel in
            let radioModel = GLRadioModel(id: directorModel.partyId, title: directorModel.partyName, subTitle: directorModel.jobName + directorModel.organName, isSelected: self?.selectedDirectorModel?.id == directorModel.partyId ? true : false, isTextFied: false, input: nil, inputPlaceHolder: nil)
            return radioModel
        })
        guard let dataArray = dataArr else { return }
        
        let radioVc = GLRadioViewController.jumpRadioVc(title: "选择客户经理", dataArray: dataArray, navigationVc: navigationController)
        radioVc.closeClosure = { [weak self] (model: GLRadioModel) in
            self?.selectedDirectorModel = model
            self?.总监Label.text = model.title
        }
    }
    

    
    @IBAction func openOrFoldBtnClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected == true {
            cell1.isHidden = false
            cell2.isHidden = false
            cell3.isHidden = false
            foldHeight1.constant = cellOpenHeight
            foldHeight2.constant = cellOpenHeight
            foldHeight3.constant = cellOpenHeight
        } else {
            cell1.isHidden = true
            cell2.isHidden = true
            cell3.isHidden = true
            foldHeight1.constant = cellFoldHeight
            foldHeight2.constant = cellFoldHeight
            foldHeight3.constant = cellFoldHeight
        }
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
        
    }
}

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
    
    var selectedMendianModel: GLRadioModel?
    
    
    
    @IBOutlet weak var switchBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        openOrFoldBtnClick(switchBtn)
        
        
        let backItem = UIBarButtonItem()
        backItem.title = "上一步";
        navigationItem.backBarButtonItem = backItem;
        
        loadData()
    }
    
    
    func loadData() -> Void {
        GLProvider.request(GLService.getCarOtherInfo(partyId: GLUser.partyId!)) { [weak self] (result) in
            if case let .success(respon) = result {
                print(JSON(respon.data))
                
            }
        }
    }
    
    @IBAction func cancelBtnClick(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextBtnClick(_ sender: UIBarButtonItem) {
        
        let vc = UIStoryboard(name: "GLCreateCarEstimate", bundle: Bundle(for: type(of: self))).instantiateViewController(withIdentifier: "GLCarMessageViewController") as! GLCarMessageViewController
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    @IBOutlet weak var 门店Label: UILabel!
    @IBAction func mendianBtnClick(_ sender: UIButton) {
        let vc = UIStoryboard(name: "GLRadio", bundle: Bundle.main).instantiateInitialViewController()
        guard let radioVc = vc as? GLRadioViewController else { return }
        radioVc.navigationItem.title = "选择所属门店"
        // 加载数据
        let path = Bundle.main.path(forResource: "mendian", ofType: "plist")
        guard let filePath = path else { return }
        let arr = NSArray(contentsOfFile: filePath)
        // 字典数组 转模型数组
        if let dataArr = [GLRadioModel].deserialize(from: arr as? [Any]) {
            var dataArray = dataArr as! [GLRadioModel]
            
            if let selectedMendianModel = selectedMendianModel {
                for (index, value) in dataArray.enumerated() {
                    if selectedMendianModel.id == value.id {
                        dataArray.replaceSubrange(Range(index...index), with: [selectedMendianModel])
                    }
                }
            }
            radioVc.dataArray = dataArray
        }
        
        radioVc.closeClosure = { [weak self] (model: GLRadioModel) in
            self?.selectedMendianModel = model
            self?.门店Label.text = model.title
        }
        
        navigationController?.pushViewController(radioVc, animated: true)
    }
    
    @IBOutlet weak var 经理Label: UILabel!
    @IBAction func jingliBtnClick(_ sender: UIButton) {
        
    }
    
    @IBOutlet weak var 主管Label: UILabel!
    @IBAction func zhuguanBtnClick(_ sender: UIButton) {
        
    }
    
    @IBOutlet weak var 总监Label: UILabel!
    @IBAction func zongjianBtnClick(_ sender: UIButton) {
        
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

//
//  GLCarStateViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/26.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring

class GLCarConfigViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backItem = UIBarButtonItem()
        backItem.title = "上一步";
        navigationItem.backBarButtonItem = backItem;
        navigationItem.title = "新建车辆评估"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一步", style: .done, target: self, action: #selector(GLCarConfigViewController.nextBtnClick(item:)))
    }
    
    @objc func nextBtnClick(item: UIBarButtonItem) {
        let vc = UIStoryboard(name: "GLCreateCarEstimate", bundle: Bundle(for: type(of: self))).instantiateViewController(withIdentifier: "GLCarStateViewController") as! GLCarStateViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func carTransmissionAction(_ sender: UIButton) {
        
        
    }
    
    var selectModels: [GLRadioModel]?
    @IBAction func carSeatFormatAction(_ sender: UIButton) {
        let multiVc = UIStoryboard(name: "GLCheckBox", bundle: Bundle(for: type(of: self))).instantiateInitialViewController() as! GLCheckBoxViewController
        
        multiVc.navigationItem.title = "选择座椅形式"
        // 加载数据
        let path = Bundle.main.path(forResource: "qita", ofType: "plist")
        guard let filePath = path else { return }
        let arr = NSArray(contentsOfFile: filePath)
        // 字典数组 转模型数组
        if let dataArr = [GLRadioModel].deserialize(from: arr as? [Any]) {
            var dataArray = dataArr as! [GLRadioModel]
            
            if let selectModels = selectModels {
                
                dataArray.enumerated().forEach({ (index, obj) in
                    selectModels.enumerated().forEach({ (i, o) in
                        if o.id == obj.id {
                            dataArray.replaceSubrange(Range(index...index), with: [o])
                        }
                    })
                })
            }
            
            multiVc.dataArray = dataArray
        }
        
        multiVc.closeClosure = { [weak self] (arr) in
            self?.selectModels = arr
        }
        
        
        
        navigationController?.pushViewController(multiVc, animated: true)
        
    }
    
}

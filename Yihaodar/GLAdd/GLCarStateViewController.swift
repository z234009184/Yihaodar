//
//  GLCarStateViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/26.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring

class GLCarStateViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backItem = UIBarButtonItem()
        backItem.title = "上一步";
        navigationItem.backBarButtonItem = backItem;
        navigationItem.title = "新建车辆评估"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一步", style: .done, target: self, action: #selector(GLCarStateViewController.nextBtnClick(item:)))
    }
    
    @objc func nextBtnClick(item: UIBarButtonItem) {
        
    }
    
    private lazy var arr = [GLCarStateView]()
    @IBOutlet weak var addView: UIView!
    @IBAction func addCarStateBtnClick(_ sender: UIButton) {
        let carStateView = Bundle.main.loadNibNamed("GLCarStateView", owner: nil, options: nil)?.first as! GLCarStateView
        contentView.addSubview(carStateView)
        
        carStateView.snp.updateConstraints { (make) in
            
            if let lastView = arr.last {
                make.top.equalTo(lastView.snp.bottom).offset(10)
            } else {
                make.top.equalTo(contentView.snp.top).offset(10)
            }
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
        }
        
        addView.snp.remakeConstraints { (make) in
            make.top.equalTo(carStateView.snp.bottom).offset(40)
        }
        arr.append(carStateView)
        
        weak var weakStateView = carStateView
        carStateView.deleteClosure = { [weak self] in
            self?.arr.removeLast()
            weakStateView?.removeFromSuperview()
            if let lastView = self?.arr.last {
                self?.addView.snp.remakeConstraints { (make) in
                    make.top.equalTo(lastView.snp.bottom).offset(40)
                }
            } else {
                self?.addView.snp.removeConstraints()
            }
            UIView.animate(withDuration: 0.25, animations: {
                self?.view.layoutIfNeeded()
            })
        }
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    
    @IBAction func questionMarkBtnClick(_ sender: UIButton) {
        
    }
    
}

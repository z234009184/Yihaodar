//
//  GLCreateCarEstimateViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/16.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring

class GLCreateCarEstimateViewController: UIViewController {
    
    @IBOutlet weak var foldHeight1: NSLayoutConstraint!
    @IBOutlet weak var foldHeight2: NSLayoutConstraint!
    @IBOutlet weak var foldHeight3: NSLayoutConstraint!
    
    let cellFoldHeight: CGFloat = 0.0
    let cellOpenHeight: CGFloat = 70.0
    
    @IBOutlet weak var cell1: UIView!
    @IBOutlet weak var cell2: UIView!
    @IBOutlet weak var cell3: UIView!
    
    
    @IBOutlet weak var 门店Label: UILabel!
    @IBAction func mendianBtnClick(_ sender: UIButton) {
        
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func cancelBtnClick(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextBtnClick(_ sender: UIBarButtonItem) {
        
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

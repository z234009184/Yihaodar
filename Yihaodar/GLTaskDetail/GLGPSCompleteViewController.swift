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

class GLGPSCompleteViewController: GLTaskDetailBaseViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var stateBtn: UIButton!
    @IBOutlet weak var topViewTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame.y = topView.frame.maxY + 1
        tableView.frame.height = view.frame.height - topView.frame.maxY - 6
    }
    
    /// 加载数据 数据驱动
    func loadData() {
        
        let section1 = GLSectionModel(title: "订单信息", items: [GLItemModel(title: "所属门店", subTitle: "朝阳事业部"), GLItemModel(title: "所属门店", subTitle: "朝阳事业部"), GLItemModel(title: "所属门店", subTitle: "朝阳事业部"), GLItemModel(title: "所属门店", subTitle: "朝阳事业部"), GLItemModel(title: "所属门店", subTitle: "朝阳事业部"), GLItemModel(title: "所属门店", subTitle: "朝阳事业部"), GLItemModel(title: "所属门店", subTitle: "朝阳事业部"), GLItemModel(title: "所属门店", subTitle: "朝阳事业部"), GLItemModel(title: "所属门店", subTitle: "朝阳事业部")])
        
        
        let section2 = GLSectionModel(title: "车辆信息", items: [GLItemModel(title: "所属门店", subTitle: "朝阳事业部"), GLFormModel(titles: ["1", "2", "3", "3"], dataArray: [["好","世界","ss","ss"], ["你","世界","ff","大家看风景看电视了就分开了多少积分卡圣诞节快乐附件圣诞快乐附件肯定是老骥伏枥看电视剧开发大家看风景看电视了就分开了多少积分卡圣诞节快乐附件圣诞快乐附件肯定是老骥伏枥看电视剧开发大家看风景看电视了就分开了多少积分卡圣诞节快乐附件圣诞快乐附件肯定是老骥伏枥看电视剧开发大家看风景看电视了就分开了多少积分卡圣诞节快乐附件圣诞快乐附件肯定是老骥伏枥看电视剧开发"], ["你好","世界","呵呵","ss"]])])
        
        
        
        let section3 = GLSectionModel(title: "图片图片", items: [GLPictureModel(pictures: ["http://www.duanhan.ren/staticgfs/504810054c8949a49bf7b36896b18b4c.jpg", "http://www.duanhan.ren/staticgfs/504810054c8949a49bf7b36896b18b4c.jpg", "http://www.duanhan.ren/staticgfs/504810054c8949a49bf7b36896b18b4c.jpg", "http://www.duanhan.ren/staticgfs/504810054c8949a49bf7b36896b18b4c.jpg", "http://www.duanhan.ren/staticgfs/504810054c8949a49bf7b36896b18b4c.jpg", "http://www.duanhan.ren/staticgfs/504810054c8949a49bf7b36896b18b4c.jpg", "http://www.duanhan.ren/staticgfs/504810054c8949a49bf7b36896b18b4c.jpg"])])
        
        
        dataArray.append(section1)
        dataArray.append(section2)
        dataArray.append(section3)
        
        tableView.reloadData()
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let contentOffsetY = scrollView.contentOffset.y
        if contentOffsetY <= 0 {
            topViewTopConstraint.constant = 0
        } else if contentOffsetY > 0 && contentOffsetY <= 65 {
            topViewTopConstraint.constant = -contentOffsetY
        } else {
            topViewTopConstraint.constant = -65
        }
    }
}


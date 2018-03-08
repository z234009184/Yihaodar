//
//  GLCarStateViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/26.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring
import FSPagerView
import SwiftyJSON

class GLCarStateViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    private lazy var arr = [GLCarStateView]()
    @IBOutlet weak var addView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backItem = UIBarButtonItem()
        backItem.title = "上一步";
        navigationItem.backBarButtonItem = backItem;
        navigationItem.title = "新建车辆评估"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一步", style: .done, target: self, action: #selector(GLCarStateViewController.nextBtnClick(item:)))
    }
    
    @objc func nextBtnClick(item: UIBarButtonItem) {
        
        /// 过滤
        var requireParam = false
        let stateArray = arr.flatMap { [weak self] (carStateView) -> GLCcrpModel? in
            if carStateView.selectedPartModel == nil {
                self?.view.makeToast("请选择车构件")
                requireParam = true
                return nil
            }
            
            if carStateView.selectedPartSubModel == nil {
                self?.view.makeToast("请选择部件")
                requireParam = true
                return nil
            }
            
            if carStateView.selectedTPartModel == nil {
                view.makeToast("请选择描述")
                requireParam = true
                return nil
            }
            
            let ccrpModel = GLCcrpModel(id: nil, cust_request_id: nil, parts_one_id: carStateView.partOneLabel.text ?? "", parts_two_id: carStateView.partTwoLabel.text ?? "", accident_type: carStateView.descLabel.text ?? "", remarks: carStateView.remarksLabel.text)
            
            return ccrpModel
            
        }
        
        if requireParam == true { return }
        
        
        /// 赋值
        GLEstimateResultViewController.summitModel.ccrpList = stateArray
        
        
        let vc = UIStoryboard(name: "GLCreateCarEstimate", bundle: Bundle(for: type(of: self))).instantiateViewController(withIdentifier: "GLUploadPictureViewController") as! GLUploadPictureViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @IBAction func addCarStateBtnClick(_ sender: UIButton) {
        
        let carStateView = Bundle.main.loadNibNamed("GLCarStateView", owner: nil, options: nil)?.first as! GLCarStateView
        contentView.addSubview(carStateView)
        
        /// 布局
        carStateView.snp.remakeConstraints { (make) in
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
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
        })
        
        weak var weakCarStateView = carStateView
        
        /// 设置数据
        carStateView.partOneClosure = { [weak self] in
            /// 处理数据
            let dataArr = GLCreateCarEstimateViewController.model?.partsList.map({ (partsModel) -> GLRadioModel in
                let radioModel = GLRadioModel(id: partsModel.id, title: partsModel.dname, subTitle: nil, isSelected: weakCarStateView?.selectedPartModel?.id == partsModel.id ? true : false, isTextFied: false, input: nil, inputPlaceHolder: nil)
                return radioModel
            })
            guard let dataArray = dataArr else { return }
            
            let radioVc = GLRadioViewController.jumpRadioVc(title: "选择车构件", dataArray: dataArray, navigationVc: self?.navigationController)
            radioVc.closeClosure = { (model: GLRadioModel) in
                weakCarStateView?.selectedPartModel = model
                weakCarStateView?.partOneLabel.text = model.title
                self?.loadPartsSubData(carStateView: weakCarStateView!)
            }
        }
        
        carStateView.partTwoClosure = { [weak self] in
            guard weakCarStateView?.selectedPartModel != nil else {
                self?.view.makeToast("请选择车构件")
                return
            }
            
            /// 处理数据
            let dataArr = GLCreateCarEstimateViewController.model?.partsSubList.map({ (partsSubModel) -> GLRadioModel in
                let isSelected = weakCarStateView?.selectedPartSubModel?.id == partsSubModel.id ? true : false
                let radioModel = GLRadioModel(id: partsSubModel.id, title: partsSubModel.dname, subTitle: nil, isSelected: isSelected, isTextFied: false, input: nil, inputPlaceHolder: nil)
                return radioModel
            })
            guard let dataArray = dataArr else { return }
            
            let radioVc = GLRadioViewController.jumpRadioVc(title: "选择部件", dataArray: dataArray, navigationVc: self?.navigationController)
            radioVc.closeClosure = { (model: GLRadioModel) in
                weakCarStateView?.selectedPartSubModel = model
                weakCarStateView?.partTwoLabel.text = model.title
            }
            
        }
        
        carStateView.descClosure = { [weak self] in
            /// 处理数据
            let dataArr = GLCreateCarEstimateViewController.model?.tpartsList.map({ (tpartsModel) -> GLRadioModel in
                let radioModel = GLRadioModel(id: tpartsModel.id, title: tpartsModel.dname, subTitle: nil, isSelected: weakCarStateView?.selectedTPartModel?.id == tpartsModel.id ? true : false, isTextFied: false, input: nil, inputPlaceHolder: nil)
                return radioModel
            })
            guard let dataArray = dataArr else { return }
            
            let radioVc = GLRadioViewController.jumpRadioVc(title: "选择车构件", dataArray: dataArray, navigationVc: self?.navigationController)
            radioVc.closeClosure = { (model: GLRadioModel) in
                weakCarStateView?.selectedTPartModel = model
                weakCarStateView?.descLabel.text = model.title
            }
        }
        
        
        
        /// 添加到数组中
        arr.append(carStateView)
        
        
        /// 删除
        carStateView.deleteClosure = { [weak self] in
            guard let weakCarStateView = weakCarStateView else { return }
            let index = self?.arr.index(of: weakCarStateView)
            guard let i = index else { return }
            self?.arr.remove(at: i)
            weakCarStateView.removeFromSuperview()
            if let firstView = self?.arr.first {
                firstView.snp.remakeConstraints { (make) in
                    make.top.equalTo((self?.contentView)!).offset(10)
                    make.left.equalTo((self?.contentView)!).offset(10)
                    make.right.equalTo((self?.contentView)!).offset(-10)
                }
            }
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
        
    }
    
    
    /// 加载部件数据
    func loadPartsSubData(carStateView: GLCarStateView) -> Void {
        guard let partOneId = carStateView.selectedPartModel?.id else {
            self.view.makeToast("车构件ID为空")
            return
        }
        self.navigationController?.view.showLoading()
        GLProvider.request(GLService.getInfoByPid(pid: partOneId)) { [weak self] (result) in
            if case let .success(respon) = result {
                let jsonStr = JSON(respon.data)
                print(jsonStr)
                
                GLCreateCarEstimateViewController.model?.partsSubList = [GLCarPartsSubModel].deserialize(from: jsonStr.rawString(), designatedPath: "results.data") as! [GLCarPartsSubModel]
                
            }
            self?.navigationController?.view.hideLoading()
        }
    }
    
    
    
    
    
    lazy var tabBarVc = navigationController?.presentingViewController as! GLTabBarController
    lazy var imgs = [#imageLiteral(resourceName: "car_state_1"), #imageLiteral(resourceName: "car_state_2")]
    @IBAction func questionMarkBtnClick(_ sender: UIButton) {

        
        let mask = tabBarVc.showMaskView()
        guard let maskView = mask else {
            return
        }
    
        
        // Create a pager view
        let pagerView = FSPagerView()
        let width = maskView.bounds.width - 20
        let height = width * 358.0/273.0
        pagerView.frame.size.width = width
        pagerView.frame.size.height = height
        pagerView.center = maskView.center
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        maskView.addSubview(pagerView)
        // Create a page control
        let pageControl = FSPageControl(frame: CGRect(x: 0, y: pagerView.frame.size.height - 20, width: pagerView.frame.size.width, height: 20))
        pagerView.addSubview(pageControl)
        
    }
}

extension GLCarStateViewController: FSPagerViewDataSource, FSPagerViewDelegate {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 2
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = imgs[index]
        
        return cell
    }
    
    
}

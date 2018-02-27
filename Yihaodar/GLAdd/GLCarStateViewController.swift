//
//  GLCarStateViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/26.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring
import FSPagerView

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
        let vc = UIStoryboard(name: "GLCreateCarEstimate", bundle: Bundle(for: type(of: self))).instantiateViewController(withIdentifier: "GLUploadPictureViewController") as! GLUploadPictureViewController
        navigationController?.pushViewController(vc, animated: true)
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
        
        
        weak var weakCarStateView = carStateView
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
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
        })
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

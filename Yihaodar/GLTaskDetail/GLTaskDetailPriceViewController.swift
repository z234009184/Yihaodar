//
//  GLTaskDetailPriceViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/24.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring
import XLPagerTabStrip
import SnapKit




class GLBasicMessageViewController: UIViewController, IndicatorInfoProvider, UIScrollViewDelegate {
    
    static var parentVc: GLTaskDetailPriceViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        GLBasicMessageViewController.parentVc = parent as? GLTaskDetailPriceViewController
        
    }
    // IndicatorInfoProvider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "基本信息")
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        
        if contentOffsetY <= 0 {
            GLBasicMessageViewController.parentVc!.topConstraint.constant = 0
        } else if contentOffsetY > 0 && contentOffsetY <= 65 {
            GLBasicMessageViewController.parentVc!.topConstraint.constant = -contentOffsetY
        } else {
            GLBasicMessageViewController.parentVc!.topConstraint.constant = -65
        }
    }
    
}
class GLEstimateMessageViewController: UIViewController, IndicatorInfoProvider, UIScrollViewDelegate {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var 车辆配置View: UIView!
    @IBOutlet weak var 评估结果View: UIView!
    @IBOutlet weak var 定价结果View: UIView!
    
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var arr = [GLEstimateCarStateView]()
        
        for index in 0..<3 {
            let estimateView = Bundle.main.loadNibNamed("GLEstimateCarStateView", owner: nil, options: nil)?.first as! GLEstimateCarStateView
            contentView.addSubview(estimateView)
            arr.append(estimateView)
            
            if index == 0 {
                estimateView.snp.updateConstraints { (make) in
                    make.top.equalTo(车辆配置View.snp.bottom).offset(10)
                    make.left.equalTo(contentView).offset(10)
                    make.right.equalTo(contentView).offset(-10)
                    make.height.equalTo(458).priority(249)
                }
            } else {
                let lastEstimateView = arr[index-1]
                estimateView.snp.updateConstraints { (make) in
                    make.top.equalTo(lastEstimateView.snp.bottom).offset(10)
                    make.left.equalTo(lastEstimateView)
                    make.right.equalTo(lastEstimateView)
                    make.height.equalTo(458).priority(249)
                }
                if (index == 2) {
                    评估结果View.snp.updateConstraints { (make) in
                        make.top.equalTo(estimateView.snp.bottom).offset(10)
                    }
                }
            }
        }
        
        
        
        
        
        
    }
    // IndicatorInfoProvider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "评估信息")
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        
        if contentOffsetY <= 0 {
            GLBasicMessageViewController.parentVc!.topConstraint.constant = 0
        } else if contentOffsetY > 0 && contentOffsetY <= 65 {
            GLBasicMessageViewController.parentVc!.topConstraint.constant = -contentOffsetY
        } else {
            GLBasicMessageViewController.parentVc!.topConstraint.constant = -65
        }
    }
   
    
}


class GLPictureMessageViewController: UIViewController, IndicatorInfoProvider, UIScrollViewDelegate {
    
    @IBOutlet weak var firstCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var firsrCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // IndicatorInfoProvider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "附件信息")
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        
        if contentOffsetY <= 0 {
            GLBasicMessageViewController.parentVc!.topConstraint.constant = 0
        } else if contentOffsetY > 0 && contentOffsetY <= 65 {
            GLBasicMessageViewController.parentVc!.topConstraint.constant = -contentOffsetY
        } else {
            GLBasicMessageViewController.parentVc!.topConstraint.constant = -65
        }
    }
}

fileprivate let identifier = "GLTaskDetailPictureCell"
extension GLPictureMessageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let count = 5
        if count == 0 {
            firstCollectionViewHeight.constant = 24
            firsrCollectionView.isHidden = true
        } else {
            firsrCollectionView.isHidden = false
            firstCollectionViewHeight.constant = CGFloat(((count-1)/3 + 1) * 100 - 10)
        }
        
        return count
    }
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        guard let pictureCell = cell as? GLTaskDetailPictureCell else {
            return UICollectionViewCell()
        }
        return pictureCell
    }
}


class GLTaskDetailPriceViewController: ButtonBarPagerTabStripViewController {
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        settings.style.buttonBarBackgroundColor = YiThemeColor
        settings.style.buttonBarItemBackgroundColor = YiThemeColor
        settings.style.selectedBarBackgroundColor = YiBlueColor
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 17)
        settings.style.selectedBarHeight = 4.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = YiSelectedTitleColor
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 1
        settings.style.buttonBarRightContentInset = 1
        
        changeCurrentIndexProgressive = {  (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = YiUnselectedTitleColor
            newCell?.label.textColor = YiSelectedTitleColor
        }
        
        super.viewDidLoad()
        
    }
    
    lazy var tabBarVc = tabBarController as! GLTabBarController
    lazy var submitMessageView: GLSubmitMessagePriceView = {
        let accessoryView = Bundle(for: GLTaskDetailPriceViewController.self).loadNibNamed("GLSubmitMessagePriceView", owner: nil, options: nil)?.first as! GLSubmitMessagePriceView
        let width = view.bounds.width
        let height = width * 190.0/375.0
        accessoryView.frame.size = CGSize(width: width, height: height)
        accessoryView.frame.origin.x = 0
        
        accessoryView.submitBtnClosure = { [weak self] in
            self?.tabBarVc.dismissCover(btn: UIButton())
            self?.tabBarVc.showLoadingView(img: #imageLiteral(resourceName: "taskdetail_submit_success"), title: "提交成功")
        }
        
        return accessoryView
    }()
    
    func showSubmitMessageView() -> Void {
        let mask = tabBarVc.showMaskView()
        guard let maskView = mask else {
            return
        }
        submitMessageView.frame.origin.y = maskView.frame.size.height
        maskView.addSubview(submitMessageView)
        
        UIView.animate(withDuration: 0.25) {
            self.submitMessageView.frame.origin.y = maskView.frame.size.height - self.submitMessageView.frame.size.height
        }
    }
    
    
    
    /// 提交评估
    @IBAction func estimateBtnClick(_ sender: DesignableButton) {
        showSubmitMessageView()
    }
    
    /// PagerTabStripDataSource
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let basicVc = UIStoryboard(name: "GLTaskDetailPrice", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLBasicMessageViewController")
        let estimateVc = UIStoryboard(name: "GLTaskDetailPrice", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLEstimateMessageViewController")
        let pictureVc = UIStoryboard(name: "GLTaskDetailPrice", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLPictureMessageViewController")
        
        return [basicVc, estimateVc, pictureVc]
    }
}

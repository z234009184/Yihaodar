//
//  GLTaskDetailPriceViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/24.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring
import XLPagerTabStrip


class GLBasicMessageViewController: UIViewController, IndicatorInfoProvider, UIScrollViewDelegate {
    
    var parentVc: GLTaskDetailPriceViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        parentVc = parent as? GLTaskDetailPriceViewController
        
    }
    // IndicatorInfoProvider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "基本信息")
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        
        if contentOffsetY <= 0 {
            parentVc!.topConstraint.constant = 0
        } else if contentOffsetY > 0 && contentOffsetY <= 65 {
            parentVc!.topConstraint.constant = -contentOffsetY
        } else {
            parentVc!.topConstraint.constant = -65
        }
    }
    
}
class GLEstimateMessageViewController: UIViewController, IndicatorInfoProvider {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
    // IndicatorInfoProvider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "评估信息")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let vc = parent as? GLTaskDetailPriceViewController else {
            return
        }
        
        vc.topConstraint.constant = 0
        
        UIView.animate(withDuration: 0.25) {
            vc.view.layoutIfNeeded()
        }
        
    }
    
}
class GLPictureMessageViewController: UIViewController, IndicatorInfoProvider {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
    // IndicatorInfoProvider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "附件信息")
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
    
    /// PagerTabStripDataSource
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let basicVc = UIStoryboard(name: "GLTaskDetailPrice", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLBasicMessageViewController")
        let estimateVc = UIStoryboard(name: "GLTaskDetailPrice", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLEstimateMessageViewController")
        let pictureVc = UIStoryboard(name: "GLTaskDetailPrice", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLPictureMessageViewController")
        
        return [basicVc, estimateVc, pictureVc]
    }
}

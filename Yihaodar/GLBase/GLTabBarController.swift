//
//  GLTabbarController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/1/30.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import UIKit
import SwiftyJSON


/// 标签栏模型
class GLTabBarItem: UITabBarItem {
    override init() {
        super.init()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}


/// 标签栏控制器
class GLTabBarController: UITabBarController {
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        
        tabBar.isTranslucent = false
        tabBar.backgroundImage = UIImage()
//        tabBar.shadowImage = UIImage()
        tabBar.barTintColor = YiThemeColor
        
        
        
    }
    
    
    var maskView: UIView?
    @objc func dismissCover(btn: UIButton?) {
        if let maskView = maskView {
            maskView.removeFromSuperview()
        }
        maskView = nil
    }
    
    
    /// 显示遮罩
    ///
    /// - Parameter isDismiss: 是否点击阴影处消失
    /// - Returns: 返回遮罩
    func showMaskView(isDismiss: Bool=true) -> UIView? {
        dismissCover(btn: nil)
        maskView = UIView(frame: self.view.bounds)
        guard let maskView = maskView else {
            return nil
        }
        maskView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        
        if isDismiss == true {
            let btn = UIButton(frame: maskView.bounds)
            maskView.addSubview(btn)
            btn.addTarget(self, action: #selector(GLTabBarController.dismissCover(btn:)), for: .touchUpInside)
            
        }
        if let vc = self.presentedViewController {
            maskView.frame = vc.view.bounds
            vc.view.addSubview(maskView)
        } else {
            self.view.addSubview(maskView)
        }
        return maskView
    }
    
    /// 显示自定义加载弹框
    ///
    /// - Parameters:
    ///   - img: 图片
    ///   - title: 文字
    func showLoadingView(img: UIImage?, title: String?) -> Void {
        _ = showMaskView(isDismiss: false)
        guard let maskView = maskView else {
            return
        }
        
        let loadingView = Bundle.main.loadNibNamed("GLSubmitLoadingView", owner: nil, options: nil)?.first as? GLSubmitLoadingView
        let width = view.bounds.width
        let height  = width * 215.0/375.0
        let y = self.view.bounds.size.height - height
        loadingView?.frame = CGRect(x: 0, y: y, width: width, height: height)
        if let img = img {
            loadingView?.imageView.image = img
        }
        if let title = title {
            loadingView?.titleLabel.text = title
        }
        guard let showView = loadingView else {
            return
        }
        
        maskView.addSubview(showView)
    }
    
    
}





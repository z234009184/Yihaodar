//
//  GLTabbarController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/1/30.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import UIKit



class GLTabBarItem: UITabBarItem {
    override init() {
        super.init()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}


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
        guard let maskView = maskView else {
            return
        }
        maskView.removeFromSuperview()
    }
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
        self.view.addSubview(maskView)
        
        return maskView
    }
    
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





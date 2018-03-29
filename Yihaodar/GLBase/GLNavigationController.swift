//
//  GLNavigationController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/1/30.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import UIKit



/// 导航控制器
class GLNavigationController:UINavigationController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : YiSelectedTitleColor], for: .normal)
        tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : YiBlueColor], for: .selected)
    }
    
    /// 状态栏颜色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    
    /// 视图加载完成
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        navigationBar.isTranslucent = false
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.barTintColor = YiThemeColor
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: YiNavigationBarTitleColor]
        navigationBar.tintColor = YiNavigationBarTitleColor
        
        setupBackBarButton(vc: topViewController)
        
        
        /// 设置返回手势
        let ges = UIScreenEdgePanGestureRecognizer(target: interactivePopGestureRecognizer?.delegate, action: Selector(("handleNavigationTransition:")))
        ges.edges = .left
        interactivePopGestureRecognizer?.view?.addGestureRecognizer(ges)
        ges.delegate = self
        interactivePopGestureRecognizer?.isEnabled = false
        
    }
    /// 设置返回按钮
    func setupBackBarButton(vc: UIViewController?) -> Void {
        let backItem = UIBarButtonItem()
        backItem.title = "返回";
        vc?.navigationItem.backBarButtonItem = backItem;
    }
    
    /// 拦截所有Push
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if (self.viewControllers.count > 0) {
            
            // 隐藏tabbar
            viewController.hidesBottomBarWhenPushed = true;
            
            
//            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "navigation_back"), style: .done, target: self, action: #selector(GLNavigationController.back))
            
            //设置返回按钮
            setupBackBarButton(vc: viewController)
            
        }
        super.pushViewController(viewController, animated: animated)
    }
    
//    @objc func back() {
//        popViewController(animated: true)
//    }
}


// MARK: - 导航控制器手势代理判断
extension GLNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return childViewControllers.count > 1
    }
}

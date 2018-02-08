//
//  GLRefreshHeader.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/8.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import PullToRefreshKit

open class GLRefreshHeader: UIView, RefreshableHeader {
    
    open class func header()->GLRefreshHeader{
        return GLRefreshHeader();
    }
    
    open var imageRenderingWithTintColor = false{
        didSet{
            if imageRenderingWithTintColor{
                imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
            }
        }
    }
    
    open let spinner:UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    open let textLabel:UILabel = UILabel(frame: CGRect(x: 0,y: 0,width: 60,height: 40))
    open let imageView:UIImageView = UIImageView(frame: CGRect.zero)
    open var durationWhenHide = 0.5
    fileprivate var textDic = [RefreshKitHeaderText:String]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        tintColor = YiRefreshTitleColor
        addSubview(spinner)
        addSubview(textLabel)
        addSubview(imageView);
        let image = UIImage(named: "arrow_down", in: Bundle(for: DefaultRefreshHeader.self), compatibleWith: nil)
        imageView.image = image
        imageView.sizeToFit()
        textLabel.font = UIFont.systemFont(ofSize: 14)
        textLabel.textAlignment = .center
        self.isHidden = true
        //Default text
        textDic[.pullToRefresh] = "下拉加载"
        textDic[.releaseToRefresh] = "松开加载"
        textDic[.refreshing] = "加载中..."
        textDic[.refreshSuccess] = "加载完成"
        textDic[.refreshFailure] = "加载完成"
        textLabel.text = textDic[.pullToRefresh]
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        textLabel.center = CGPoint(x: frame.size.width/2, y: frame.size.height/2);
        imageView.center = CGPoint(x: textLabel.frame.origin.x - 30, y: frame.size.height/2)
        spinner.center = imageView.center
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setText(_ text:String,mode:RefreshKitHeaderText){
        textDic[mode] = text
    }
    
    // MARK: - Refreshable  -
    public func heightForHeader() -> CGFloat {
        return 50
    }
    
    public func percentUpdateDuringScrolling(_ percent: CGFloat) {
        self.isHidden = false
    }
    
    public func stateDidChanged(_ oldState: RefreshHeaderState, newState: RefreshHeaderState) {
        if oldState == RefreshHeaderState.idle && newState == RefreshHeaderState.pulling{
            textLabel.text = textDic[.releaseToRefresh]
            guard self.imageView.transform == CGAffineTransform.identity else{
                return
            }
            UIView.animate(withDuration: 0.4, animations: {
                self.imageView.transform = CGAffineTransform(rotationAngle: -CGFloat.pi+0.000001)
            })
        }
        if oldState == RefreshHeaderState.pulling && newState == RefreshHeaderState.idle {
            textLabel.text = textDic[.pullToRefresh]
            guard self.imageView.transform == CGAffineTransform(rotationAngle: -CGFloat.pi+0.000001)  else{
                return
            }
            UIView.animate(withDuration: 0.4, animations: {
                self.imageView.transform = CGAffineTransform.identity
            })
        }
    }
    
    open func durationOfHideAnimation() -> Double {
        return durationWhenHide
    }
    
    open func didBeginHideAnimation(_ result:RefreshResult) {
        spinner.stopAnimating()
        imageView.transform = CGAffineTransform.identity
        imageView.isHidden = false
        switch result {
        case .success:
            textLabel.text = textDic[.refreshSuccess]
            imageView.image = UIImage(named: "success", in: Bundle(for: DefaultRefreshHeader.self), compatibleWith: nil)
        case .failure:
            textLabel.text = textDic[.refreshFailure]
            imageView.image = UIImage(named: "failure", in: Bundle(for: DefaultRefreshHeader.self), compatibleWith: nil)
        case .none:
            textLabel.text = textDic[.pullToRefresh]
            imageView.image = UIImage(named: "arrow_down", in: Bundle(for: DefaultRefreshHeader.self), compatibleWith: nil)
        }
        if imageRenderingWithTintColor{
            imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        }
    }
    open func didCompleteHideAnimation(_ result:RefreshResult) {
        textLabel.text = textDic[.pullToRefresh]
        self.isHidden = true
        imageView.image = UIImage(named: "arrow_down", in: Bundle(for: DefaultRefreshHeader.self), compatibleWith: nil)
        if imageRenderingWithTintColor{
            imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        }
    }
    open func didBeginRefreshingState() {
        self.isHidden = false
        textLabel.text = textDic[.refreshing]
        spinner.startAnimating()
        imageView.isHidden = true
    }
    
    override open var tintColor: UIColor!{
        didSet{
            textLabel.textColor = tintColor
            spinner.color = tintColor
            imageView.tintColor = tintColor
        }
    }
}

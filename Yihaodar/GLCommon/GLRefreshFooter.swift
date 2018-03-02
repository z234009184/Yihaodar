//
//  GLRefreshFooter.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/14.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import PullToRefreshKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}

open class GLRefreshFooter:UIView, RefreshableFooter{
    open static func footer()-> GLRefreshFooter{
        return GLRefreshFooter()
    }
    open let spinner:UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    open  let textLabel:UILabel = UILabel(frame: CGRect(x: 0,y: 0,width: 80,height: 40))
    let imageView = UIImageView(image: #imageLiteral(resourceName: "refresh_bottom_nodata_img"))
    /// 触发刷新的模式
    open var refreshMode = RefreshMode.scroll{
        didSet{
            tap.isEnabled = (refreshMode != .scroll)
            udpateTextLabelWithMode(refreshMode)
        }
    }
    
    fileprivate func udpateTextLabelWithMode(_ refreshMode:RefreshMode){
        switch refreshMode {
        case .scroll:
            textLabel.text = textDic[.pullToRefresh]
        case .tap:
            textLabel.text = textDic[.tapToRefresh]
        case .scrollAndTap:
            textLabel.text = textDic[.scrollAndTapToRefresh]
        }
    }
    
    fileprivate var tap:UITapGestureRecognizer!
    fileprivate var textDic = [RefreshKitFooterText:String]()
    /**
     This function can only be called before Refreshing
     */
    open  func setText(_ text:String,mode:RefreshKitFooterText){
        textDic[mode] = text
        textLabel.text = textDic[.pullToRefresh]
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tintColor = YiUnselectedTitleColor
        addSubview(spinner)
        addSubview(textLabel)
        addSubview(imageView)
        imageView.isHidden = true
        textDic[.pullToRefresh] = "上拉加载"
        textDic[.refreshing] = "加载中..."
        textDic[.noMoreData] = "我是有底线的"
        textDic[.tapToRefresh] = "点击加载"
        textDic[.scrollAndTapToRefresh] = "上拉点击加载"
        udpateTextLabelWithMode(refreshMode)
        textLabel.font = UIFont.systemFont(ofSize: 14)
        textLabel.textAlignment = .center
        tap = UITapGestureRecognizer(target: self, action: #selector(GLRefreshFooter.catchTap(_:)))
        self.addGestureRecognizer(tap)
    }
    open override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.center = CGPoint(x: frame.size.width/2, y: frame.size.height/2);
        spinner.center = CGPoint(x: textLabel.frame.origin.x - 20, y: frame.size.height/2)
        imageView.center = textLabel.center
    }
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func catchTap(_ tap:UITapGestureRecognizer){
        let scrollView = self.superview?.superview as? UIScrollView
        scrollView?.switchRefreshFooter(to: .refreshing)
    }
    
    // MARK: - Refreshable  -
    open func heightForFooter() -> CGFloat {
        return 44.0
    }
    open func didBeginRefreshing() {
        self.isUserInteractionEnabled = true
        textLabel.text = textDic[.refreshing];
        spinner.startAnimating()
        imageView.isHidden = true
        textLabel.isHidden = false
    }
    open func didEndRefreshing() {
        udpateTextLabelWithMode(refreshMode)
        spinner.stopAnimating()
    }
    open func didUpdateToNoMoreData(){
        self.isUserInteractionEnabled = false;
        textLabel.text = textDic[.noMoreData]
        textLabel.isHidden = true
        imageView.isHidden = false
    }
    open func didResetToDefault() {
        self.isUserInteractionEnabled = true
        udpateTextLabelWithMode(refreshMode)
        imageView.isHidden = true
        textLabel.isHidden = false
    }
    open func shouldBeginRefreshingWhenScroll()->Bool {
        return refreshMode != .tap
    }
    // MARK: - Handle touch -
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard refreshMode != .scroll else{
            return
        }
        self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
    }
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard refreshMode != .scroll else{
            return
        }
        self.backgroundColor = UIColor.white
    }
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        guard refreshMode != .scroll else{
            return
        }
        self.backgroundColor = UIColor.white
    }
    override open var tintColor: UIColor!{
        didSet{
            textLabel.textColor = tintColor
            spinner.color = tintColor
        }
    }
}

class RefreshFooterContainer:UIView{
    enum RefreshFooterState {
        case idle
        case refreshing
        case willRefresh
        case noMoreData
    }
    // MARK: - Propertys -
    var refreshAction:(()->())?
    var attachedScrollView:UIScrollView!
    weak var delegate:RefreshableFooter?
    fileprivate var _state:RefreshFooterState = .idle
    var state: RefreshFooterState{
        get{
            return _state
        }
        set{
            guard newValue != _state else{
                return
            }
            _state =  newValue
            if newValue == .refreshing{
                DispatchQueue.main.async(execute: {
                    self.delegate?.didBeginRefreshing()
                    self.refreshAction?()
                })
            }else if newValue == .noMoreData{
                self.delegate?.didUpdateToNoMoreData()
            }else if newValue == .idle{
                self.delegate?.didResetToDefault()
            }
        }
    }
    // MARK: - Init -
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    func commonInit(){
        self.backgroundColor = UIColor.clear
        self.autoresizingMask = .flexibleWidth
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life circle -
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if self.state == .willRefresh {
            self.state = .refreshing
        }
    }
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        guard newSuperview != nil else{ //remove from superview
            if !self.isHidden{
                var inset = attachedScrollView.contentInset
                inset.bottom = inset.bottom - self.frame.height
                attachedScrollView.contentInset = inset
            }
            return
        }
        guard newSuperview is UIScrollView else{
            return;
        }
        attachedScrollView = newSuperview as? UIScrollView
        attachedScrollView.alwaysBounceVertical = true
        if !self.isHidden {
            var contentInset = attachedScrollView.contentInset
            contentInset.bottom = contentInset.bottom + self.frame.height
            attachedScrollView.contentInset = contentInset
        }
        self.frame = CGRect(x: 0,y: attachedScrollView.contentSize.height,width: self.frame.width, height: self.frame.height)
        addObservers()
    }
    deinit{
        removeObservers()
    }
    
    // MARK: - Private -
    fileprivate func addObservers(){
        attachedScrollView?.addObserver(self, forKeyPath:"contentOffset", options: [.old,.new], context: nil)
        attachedScrollView?.addObserver(self, forKeyPath:"contentSize", options:[.old,.new] , context: nil)
        attachedScrollView?.panGestureRecognizer.addObserver(self, forKeyPath:"state", options:[.old,.new] , context: nil)
    }
    fileprivate func removeObservers(){
        attachedScrollView?.removeObserver(self, forKeyPath: "contentSize",context: nil)
        attachedScrollView?.removeObserver(self, forKeyPath: "contentOffset",context: nil)
        attachedScrollView?.panGestureRecognizer.removeObserver(self, forKeyPath: "state",context: nil)
    }
    func handleScrollOffSetChange(_ change: [NSKeyValueChangeKey : Any]?){
        if state != .idle && self.frame.origin.y != 0{
            return
        }
        let insetTop = attachedScrollView.contentInset.top
        let contentHeight = attachedScrollView.contentSize.height
        let scrollViewHeight = attachedScrollView.frame.size.height
        if insetTop + contentHeight > scrollViewHeight{
            let offSetY = attachedScrollView.contentOffset.y
            if offSetY > self.frame.origin.y - scrollViewHeight + attachedScrollView.contentInset.bottom{
                let oldOffset = (change?[NSKeyValueChangeKey.oldKey] as AnyObject).cgPointValue
                let newOffset = (change?[NSKeyValueChangeKey.newKey] as AnyObject).cgPointValue
                guard newOffset?.y > oldOffset?.y else{
                    return
                }
                let shouldStart = self.delegate?.shouldBeginRefreshingWhenScroll()
                guard shouldStart! else{
                    return
                }
                beginRefreshing()
            }
        }
    }
    func handlePanStateChange(_ change: [NSKeyValueChangeKey : Any]?){
        guard state == .idle else{
            return
        }
        if attachedScrollView.panGestureRecognizer.state == .ended {
            let scrollInset = attachedScrollView.contentInset
            let scrollOffset = attachedScrollView.contentOffset
            let contentSize = attachedScrollView.contentSize
            if scrollInset.top + contentSize.height <= attachedScrollView.frame.height{
                if scrollOffset.y >= -1 * scrollInset.top {
                    let shouldStart = self.delegate?.shouldBeginRefreshingWhenScroll()
                    guard shouldStart! else{
                        return
                    }
                    beginRefreshing()
                }
            }else{
                if scrollOffset.y > contentSize.height + scrollInset.bottom - attachedScrollView.frame.height {
                    let shouldStart = self.delegate?.shouldBeginRefreshingWhenScroll()
                    guard shouldStart! else{
                        return
                    }
                    beginRefreshing()
                }
            }
        }
    }
    func handleContentSizeChange(_ change: [NSKeyValueChangeKey : Any]?){
        self.frame = CGRect(x: 0,y: self.attachedScrollView.contentSize.height,width: self.frame.size.width,height: self.frame.size.height)
    }
    // MARK: - KVO -
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentOffset" && self.isUserInteractionEnabled{
            handleScrollOffSetChange(change)
        }
        guard !self.isHidden else{
            return;
        }
        if keyPath == "state" && self.isUserInteractionEnabled{
            handlePanStateChange(change)
        }
        if keyPath == "contentSize" {
            handleContentSizeChange(change)
        }
    }
    // MARK: - API -
    func beginRefreshing(){
        if self.window != nil {
            self.state = .refreshing
        }else{
            if state != .refreshing{
                self.state = .willRefresh
            }
        }
    }
    func endRefreshing(){
        self.state = .idle
        self.delegate?.didEndRefreshing()
    }
    func resetToDefault(){
        self.state = .idle
    }
    func updateToNoMoreData(){
        self.state = .noMoreData
    }
}

//
//  GLWorkTableController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/1/31.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import XLPagerTabStrip
import HGPlaceholders
import PullToRefreshKit
import Spring

// MARK: - GLWorkTableListCell
/// GLWorkTableListCell
class GLWorkTableListCell: UITableViewCell {
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}



// MARK: - 带有placeholder的tableView
/// 带有placeholder的tableView
class PlaceHolderTableView: TableView {
    override func customSetup() {
        placeholdersProvider = .default
        
        var noResultsData: PlaceholderData = .noResults
        noResultsData.title = ""
        noResultsData.action = nil
        noResultsData.subtitle = "暂时没有任务"
        noResultsData.image = #imageLiteral(resourceName: "tableview_nodata_placeholder")
        let noResultsPlaceholder = Placeholder(data: noResultsData, style: PlaceholderStyle(), key: .noResultsKey)
        placeholdersProvider.add(placeholders: noResultsPlaceholder)
        
    }
}
// MARK: - 待办控制器
/// 待办控制器
class GLDaiBanController: UITableViewController {

    
    var placeholderTableView: PlaceHolderTableView?
    
    private let reusableIdentifier = "GLWorkTableListCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placeholderTableView = tableView as? PlaceHolderTableView
        placeholderTableView?.placeholderDelegate = self
        placeholderTableView?.placeholdersAlwaysBounceVertical = true
        tableView.configRefreshHeader(with: GLRefreshHeader.header()) { [weak self] in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
                self?.tableView.switchRefreshHeader(to: .normal(.success, 0.5))
                self?.tableView.reloadData()
            })
        }
        
        tableView.configRefreshFooter(with: GLRefreshFooter.footer()) { [weak self] in
            self?.tableView.switchRefreshFooter(to: .refreshing)
            
        }
        
        
        tableView.switchRefreshHeader(to: .refreshing)
    }
    
    
    
    
    
}

extension GLDaiBanController: PlaceholderDelegate, IndicatorInfoProvider {
    func view(_ view: Any, actionButtonTappedFor placeholder: Placeholder) {
        print(placeholder.key.value)
    }
    
    // IndicatorInfoProvider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "代办任务")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = 10
        return Int(count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier) else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let parentVc = parent else { return }
        
//        let desVc = UIStoryboard(name: "GLTaskDetail", bundle: nil).instantiateInitialViewController()
//        guard let destinationVc = desVc as? GLTaskDetailViewController else { return }
//        destinationVc.isInvalid = true
//        parentVc.navigationController?.pushViewController(destinationVc, animated: true)

        let desVc = UIStoryboard(name: "GLTaskDetailPicture", bundle: nil).instantiateInitialViewController()
        guard let destinationVc = desVc as? GLTaskDetailPictureViewController else { return }
        parentVc.navigationController?.pushViewController(destinationVc, animated: true)
        
    }
}





// MARK: - 已完成控制器
/// 已完成控制器
class GLWanChengController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        
        
    }
    
}

extension GLWanChengController: IndicatorInfoProvider {
    // IndicatorInfoProvider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "已完成任务")
    }
}







// MARK: - 工作台控制器
/// 工作台控制器
class GLWorkTableController: ButtonBarPagerTabStripViewController {
    
    
    override func viewDidLoad() {
        
//        edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        
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
        
        setupRightBarItems()
        
    }
    
    func setupRightBarItems() -> Void {
        
        
        let rightBarItemsView = UIView(frame: CGRect(x: 0, y: 0, width: 54, height: 18))
        
        let searchBtn = UIButton(type: .custom)
        searchBtn.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        searchBtn.setImage(#imageLiteral(resourceName: "navigation_search_icon"), for: .normal)
        searchBtn.sizeToFit()
        searchBtn.addTarget(self, action: #selector(GLWorkTableController.searchAction(_:)), for: UIControlEvents.touchUpInside)

        let addBtn = UIButton(type: .custom)
        addBtn.frame = CGRect(x: 36, y: 0, width: 18, height: 18)
        addBtn.setImage(#imageLiteral(resourceName: "navigation_add_icon"), for: .normal)
        addBtn.sizeToFit()
        addBtn.addTarget(self, action: #selector(GLWorkTableController.addAction(_:)), for: UIControlEvents.touchUpInside)
        
        rightBarItemsView.addSubview(searchBtn)
        rightBarItemsView.addSubview(addBtn)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarItemsView)
    }
    
    @objc func searchAction(_ btn: UIButton) -> Void {
        
        let vc = UIStoryboard(name: "GLSearch", bundle: Bundle.main).instantiateInitialViewController()
        guard let searchVc = vc as? GLSearchViewController else { return }
        navigationController?.pushViewController(searchVc, animated: true)
        
    }
    
    
    @objc func addAction(_ btn: UIButton) -> Void {
        showAddView()
    }
    
    
    func showAddView() -> Void {
        
        let maskView = DesignableView(frame: (navigationController?.view.bounds)!)
        maskView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        let btn = UIButton(frame: maskView.bounds)
        btn.addTarget(self, action: #selector(GLWorkTableController.dismissCover(btn:)), for: .touchUpInside)
        maskView.addSubview(btn)
        tabBarController?.view.addSubview(maskView)
        
        let addViewY = 167.0*UIScreen.main.bounds.size.height/667.0
        let addViewH = UIScreen.main.bounds.size.height - addViewY
        
        let addV = Bundle.main.loadNibNamed("GLAddView", owner: nil, options: nil)?.first
        guard let addView = addV as? GLAddView else { return }
        addView.frame = CGRect(x: 0, y: addViewY, width: maskView.bounds.size.width, height: addViewH)
        maskView.addSubview(addView)
        
        addView.closeClosure = { [weak self] in
            self?.dismissCover(btn: btn)
        }
        addView.createEstimateClosure = { [weak self] in
            guard let vc = UIStoryboard(name: "GLCreateCarEstimate", bundle: Bundle.main).instantiateInitialViewController() else {
                return
            }
            
            self?.present(vc, animated: true, completion: nil)
            
            self?.dismissCover(btn: btn)
        }
    }
    
    
    @objc func dismissCover(btn: UIButton) {
        btn.superview?.removeFromSuperview()
    }
    
  
    
    /// PagerTabStripDataSource
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let daibanVc = UIStoryboard(name: "GLWorkTable", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLDaiBanController")
        
        return [daibanVc, GLWanChengController()]
    }
    
    
}



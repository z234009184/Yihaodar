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
import SwiftyJSON
import HandyJSON

/// 列表模型
struct GLWorkTableModel: HandyJSON {
    var organiserRoles: String?
    var takeStatus: String?
    var startDate: String?
    var taskType: String?
    var executionId: String?
    var processName: String?
    var processTaskId: String?
    var executionData: String?
    var executionString: String? {
        get{
            if let d = executionData?.data(using: String.Encoding.utf8) {
               return JSON(d)["brandStyle"].stringValue + JSON(d)["brandName"].stringValue + JSON(d)["brandSeries"].stringValue
            }
            return executionData
        }
    }
    var processId: String?
    var endDate: String?
    var taskName: String?
    var organiser: String?
    var processType: String?
    var store_name: String?
    var status : TaskType {
        get {
            if taskType == "BDGOODS_ASSESS_TASK" {
                if executionData?.isEmpty == true {
                    return TaskType.speedEstimate
                } else {
                    return TaskType.manualEstimate
                }
            } else if taskType == "CARS_ASSESS_TASK" {
                return TaskType.price
            } else {
                return TaskType.unknow
            }
        }
    }
    var statusBtnName : String? {
        get {
            if taskType == "BDGOODS_ASSESS_TASK" {
                return "评估"
            } else if taskType == "CARS_ASSESS_TASK" {
                return "定价"
            } else {
                return "未知"
            }
        }
    }
    
    /// 类型: 手动/极速/定价
    enum TaskType {
        case manualEstimate
        case speedEstimate
        case price
        case unknow
    }
    
}


// MARK: - GLWorkTableListCell
/// GLWorkTableListCell
class GLWorkTableListCell: UITableViewCell {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBOutlet weak var titleNumLabel: DesignableLabel!
    @IBOutlet weak var nameLabel: DesignableLabel!
    @IBOutlet weak var dateLabel: DesignableLabel!
    
    @IBOutlet weak var stateBtn: DesignableButton!
    
    
    var listModel: GLWorkTableModel? {
        didSet {
            
            titleNumLabel.text = listModel?.executionId
            nameLabel.text = listModel?.executionString
            dateLabel.text = listModel?.startDate
            stateBtn.setTitle(listModel?.statusBtnName, for: .normal)
        }
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
        self.placeholdersAlwaysBounceVertical = true
    }
}







// MARK: - 待办控制器
/// 待办控制器
class GLDaiBanController: UITableViewController {

    private var placeholderTableView: PlaceHolderTableView?
    private let reusableIdentifier = "GLWorkTableListCell"
    private let pageSize = 8
    private var startIndex = 0
    private var dataArray = [GLWorkTableModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.configRefreshHeader(with: GLRefreshHeader.header()) { [weak self] in
                self?.startIndex = 0
                self?.dataArray.removeAll()
                self?.loadData(success: {
                    self?.tableView.switchRefreshHeader(to: .normal(.success, 0.5))
                    self?.tableView.reloadData()
                })
            
        }
        
        tableView.configRefreshFooter(with: GLRefreshFooter.footer()) { [weak self] in
            self?.tableView.switchRefreshFooter(to: .refreshing)
            
        }
        
        
        tableView.switchRefreshHeader(to: .refreshing)
    }
    
    
    func loadData(success: @escaping ()->()) {
        GLProvider.request(GLService.todoList(partyId: GLUser.partyId!, pageSize: "\(pageSize)", startIndex: "\(startIndex)"))  { [weak self] (result) in
            if self == nil {return}
            if case let .success(response) = result {
                let json = JSON(response.data)
                print(json)
                if json["type"] != "S" { return }

                guard let models = [GLWorkTableModel].deserialize(from: json["results"]["rows"].arrayObject) as? [GLWorkTableModel] else { return }
                if models.count > 0 {
                    self?.startIndex += 1
                    self?.dataArray = (self?.dataArray)! + models
                } else {
                    // TODO: ------
                }
                success()
            }
        }
    }
}

extension GLDaiBanController: IndicatorInfoProvider {
    // IndicatorInfoProvider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "代办任务")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier) as? GLWorkTableListCell else {
            return UITableViewCell()
        }
        
        cell.listModel = dataArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let parentVc = parent else { return }
        
        if indexPath.row == 0 {
            let desVc = UIStoryboard(name: "GLTaskDetail", bundle: nil).instantiateInitialViewController()
            guard let destinationVc = desVc as? GLTaskDetailViewController else { return }
            destinationVc.isInvalid = false
            parentVc.navigationController?.pushViewController(destinationVc, animated: true)
        }
        if indexPath.row == 1 { //
            let desVc = UIStoryboard(name: "GLTaskDetailPicture", bundle: nil).instantiateInitialViewController()
            guard let destinationVc = desVc as? GLTaskDetailPictureViewController else { return }
            parentVc.navigationController?.pushViewController(destinationVc, animated: true)
        }
        if indexPath.row == 2 { // 待定价
            let desVc = UIStoryboard(name: "GLTaskDetailPrice", bundle: nil).instantiateInitialViewController()
            guard let destinationVc = desVc as? GLTaskDetailPriceViewController else { return }
            parentVc.navigationController?.pushViewController(destinationVc, animated: true)
        }
        
    }
}





// MARK: - 已完成控制器
/// 已完成控制器
class GLWanChengController: UITableViewController {
    
    
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

extension GLWanChengController: IndicatorInfoProvider, PlaceholderDelegate {
    func view(_ view: Any, actionButtonTappedFor placeholder: Placeholder) {
        
    }
    
    // IndicatorInfoProvider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "已完成任务")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = 3
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
        
        if indexPath.row == 0 {
            let desVc = UIStoryboard(name: "GLTaskDetail", bundle: nil).instantiateInitialViewController()
            guard let destinationVc = desVc as? GLTaskDetailViewController else { return }
            destinationVc.isInvalid = true
            parentVc.navigationController?.pushViewController(destinationVc, animated: true)
        }
        if indexPath.row == 1 { //
            let desVc = UIStoryboard(name: "GLTaskDetailPicture", bundle: nil).instantiateInitialViewController()
            guard let destinationVc = desVc as? GLTaskDetailPictureViewController else { return }
            parentVc.navigationController?.pushViewController(destinationVc, animated: true)
        }
        if indexPath.row == 2 { // 待定价
            
        }
        
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
        let wanchengVc = UIStoryboard(name: "GLWorkTable", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLWanChengController")
        return [daibanVc, wanchengVc]
    }
    
    
}



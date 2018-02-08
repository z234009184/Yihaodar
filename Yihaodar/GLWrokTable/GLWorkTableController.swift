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
    
        
        tableView.configRefreshHeader(with: GLRefreshHeader.header()) { [weak self] in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                self?.tableView.switchRefreshHeader(to: .normal(.success, 0.5))
                self?.tableView.reloadData()
            })
        }
    }
}

extension GLDaiBanController: PlaceholderDelegate, IndicatorInfoProvider {
    func view(_ view: Any, actionButtonTappedFor placeholder: Placeholder) {
        print(placeholder.key.value)
        tableView.reloadData()
    }
    
    // IndicatorInfoProvider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "代办任务")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = arc4random() % 30
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
        
        let desVc = UIStoryboard(name: "GLTaskDetail", bundle: nil).instantiateInitialViewController()
        guard let destinationVc = desVc else { return }
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
        
    }
    
    
    /// PagerTabStripDataSource
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let daibanVc = UIStoryboard(name: "GLWorkTable", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLDaiBanController")
        
        return [daibanVc, GLWanChengController()]
    }
    
    
}



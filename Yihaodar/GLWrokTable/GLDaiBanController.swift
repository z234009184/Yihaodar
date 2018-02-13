//
//  GLDaiBanController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/13.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring
import PullToRefreshKit

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



//
//  GLSearchViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/8.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import UIKit
import HGPlaceholders
import SwiftyJSON

class GLSearchViewController: GLWorkTableBaseViewController {
    
    var placeholderTableView: PlaceHolderTableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        setupTableView()
        
        tableView.configRefreshFooter(with: GLRefreshFooter.footer()) { [weak self] in
            self?.loadData()
        }
        
        
    }
    
    func loadData() {
        
        
        let executionId = (navigationItem.titleView as! UISearchBar).text
        GLProvider.request(GLService.searchList(partyId: GLUser.partyId!, pageSize: "\(pageSize)", startIndex: "\(startIndex)", executionId: executionId!))  { [weak self] (result) in
            if self == nil {return}
            
            if case let .success(response) = result {
                if self?.startIndex == 1 {
                    self?.dataArray.removeAll()
                }
                let json = JSON(response.data)
                print(json)
                if let models = [GLWorkTableModel].deserialize(from: json["results"]["rows"].arrayObject) as? [GLWorkTableModel] {
                    // 拼接数据
                    self?.dataArray = (self?.dataArray)! + models
                    
                    if models.count >= (self?.pageSize)! { // 大于一页 可以进行加载
                        self?.startIndex += 1
                        self?.tableView.switchRefreshFooter(to: .normal)
                    } else { // 无更多数据
                        self?.tableView.switchRefreshFooter(to: .noMoreData)
                    }
                }
            }
            self?.tableView.switchRefreshHeader(to: .normal(.success, 0.5))
            self?.tableView.reloadData()
        }
    }
    
    
    func setupTableView() -> Void {
        placeholderTableView = tableView as? PlaceHolderTableView
        placeholderTableView?.placeholdersAlwaysBounceVertical = true
        placeholderTableView?.placeholdersProvider = .default
        var noResultsData: PlaceholderData = .noResults
        noResultsData.title = ""
        noResultsData.action = nil
        noResultsData.subtitle = "暂时没有相关信息"
        noResultsData.image = #imageLiteral(resourceName: "tableview_nodata_img")
        let noResultsPlaceholder = Placeholder(data: noResultsData, style: PlaceholderStyle(), key: .noResultsKey)
        placeholderTableView?.placeholdersProvider.add(placeholders: noResultsPlaceholder)
    }
    
    func setupNavigationBar() -> Void {
        navigationItem.leftBarButtonItem = nil
        navigationItem.hidesBackButton = true
        
        // 实例化
        let searchbar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        navigationItem.titleView = searchbar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消", style: .done, target: self, action: #selector(GLSearchViewController.cancelBtn(item:)))
        
        searchbar.barStyle = UIBarStyle.default
        
        searchbar.placeholder = "搜索"
        searchbar.tintColor = YiSelectedTitleColor
        searchbar.searchBarStyle = .minimal
        
        searchbar.showsCancelButton = false
        searchbar.delegate = self
        // 键盘类型设置
        searchbar.returnKeyType = .search
        
        // 第一响应，即进入编辑状态
        searchbar.becomeFirstResponder()
//        let uiButton = searchbar.value(forKey: "cancelButton") as! UIButton
//        uiButton.setTitle("取消", for: .normal)
//        uiButton.setTitleColor(YiSelectedTitleColor,for: .normal)
    }
    
    @objc func cancelBtn(item: UIBarButtonItem)  {
        (navigationItem.titleView as! UISearchBar).endEditing(true)
        navigationController?.popViewController(animated: true)
    }
}

extension GLSearchViewController : UISearchBarDelegate {
    // 实现代理方法
    // MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("3 searchBar")
        
        print("3 text=\(String(describing: searchBar.text)), string=\(searchText)")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        startIndex = 1
        loadData()
    }
    
    
}

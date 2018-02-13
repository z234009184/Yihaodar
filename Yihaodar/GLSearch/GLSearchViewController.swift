//
//  GLSearchViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/8.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import UIKit
import HGPlaceholders

class GLSearchViewController: UITableViewController {
    
    var placeholderTableView: PlaceHolderTableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        setupTableView()
        
    }
    
    func setupTableView() -> Void {
        placeholderTableView = tableView as? PlaceHolderTableView
        placeholderTableView?.placeholderDelegate = self
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
        
        searchbar.barStyle = UIBarStyle.default
        
        searchbar.placeholder = "搜索"
        searchbar.tintColor = YiSelectedTitleColor
        searchbar.searchBarStyle = .minimal
        
        searchbar.showsCancelButton = true
        searchbar.delegate = self
        // 键盘类型设置
        searchbar.returnKeyType = .search
        
        // 第一响应，即进入编辑状态
        searchbar.becomeFirstResponder()
        let uiButton = searchbar.value(forKey: "cancelButton") as! UIButton
        uiButton.setTitle("取消", for: .normal)
        uiButton.setTitleColor(YiSelectedTitleColor,for: .normal)
    }
}

extension GLSearchViewController : PlaceholderDelegate {
    func view(_ view: Any, actionButtonTappedFor placeholder: Placeholder) {
        
    }
    
    
}


extension GLSearchViewController : UISearchBarDelegate {
    // 实现代理方法
    // MARK: - UISearchBarDelegate
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool  {
        print("1 searchBarShouldBeginEditing")
        
        return true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("2 searchBarTextDidBeginEditing")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("3 searchBar")
        
        print("3 text=\(String(describing: searchBar.text)), string=\(searchText)")
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print("4 searchBar")
        
        print("4 text=\(String(describing: searchBar.text)), range=\(range), string=\(text)")
        
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool
    {
        print("5 searchBarShouldEndEditing")
        
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("6 searchBarTextDidEndEditing")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("7 searchBarSearchButtonClicked")
        
        searchBar.endEditing(true)
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print("8 searchBarBookmarkButtonClicked")
        
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("9 searchBarCancelButtonClicked")
        searchBar.endEditing(true)
        navigationController?.popViewController(animated: true)
    }
    
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        print("10 searchBarResultsListButtonClicked")
        
        searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        print("11 searchBar")
    }
}

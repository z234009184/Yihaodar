//
//  GLTaskDetailGPSViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/3/25.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring
import XLPagerTabStrip
import HandyJSON

struct GLItemModel: HandyJSON {
    var title = ""
    var subTitle = ""
}

/// 数据层
struct GLSectionModel: HandyJSON {
    var title = ""
    var items: [GLItemModel] = []
}



class GLTaskDetailItemHeader: UITableViewHeaderFooterView {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var sectionModel: GLSectionModel? {
        didSet{
            titleLabel.text = sectionModel?.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .white
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
}


class GLTaskDetailItemCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    var itemModel: GLItemModel? {
        didSet{
            titleLabel.text = itemModel?.title
            subTitleLabel.text = itemModel?.subTitle
            
            if subTitleLabel.text?.isEmpty == true {
                subTitleLabel.text = "未填写"
                subTitleLabel.textColor = YiUnselectedTitleColor
            } else {
                subTitleLabel.textColor = YiSelectedTitleColor
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
}

class GLTaskDetailBaseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    open lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 8, y: 0, width: view.frame.size.width-16, height: view.frame.size.height), style: UITableViewStyle.grouped)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none

        tableView.estimatedRowHeight = 40
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "GLTaskDetailItemCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: GLTaskDetailItemCellId)
        tableView.register(UINib(nibName: "GLTaskDetailItemHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: GLTaskDetailItemHeaderId)
        tableView.contentInset = UIEdgeInsetsMake(8, 0, 0, 0)
        return tableView
    }()
    
    fileprivate let GLTaskDetailItemCellId = "GLTaskDetailItemCellId"
    fileprivate let GLTaskDetailItemHeaderId = "GLTaskDetailItemHeaderId"
    
    open var dataArray: [GLSectionModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 8, y: 0, width: view.frame.size.width-16, height: view.frame.size.height)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionModel = dataArray[section]
        return sectionModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GLTaskDetailItemCellId) as? GLTaskDetailItemCell else {
            return Bundle.main.loadNibNamed("GLTaskDetailItemCell", owner: nil, options: nil)?.first as! GLTaskDetailItemCell
        }
        let sectionModel = dataArray[indexPath.section]
        let itemModel = sectionModel.items[indexPath.row]
        cell.itemModel = itemModel
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: GLTaskDetailItemHeaderId) as? GLTaskDetailItemHeader else {
            return GLTaskDetailItemHeader(reuseIdentifier: GLTaskDetailItemHeaderId)
        }
        sectionHeader.sectionModel = dataArray[section]
        
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == dataArray.count - 1 {
            return 0.01
        }
        return 8
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard let parentVc = parent as? GLTaskDetailGPSViewController else {
            return
        }
        let contentOffsetY = scrollView.contentOffset.y
        if contentOffsetY <= 0 {
            parentVc.topViewTopConstraint.constant = 0
        } else if contentOffsetY > 0 && contentOffsetY <= 65 {
            parentVc.topViewTopConstraint.constant = -contentOffsetY
        } else {
            parentVc.topViewTopConstraint.constant = -65
        }
    }
}



class GL基本信息ViewController: GLTaskDetailBaseViewController, IndicatorInfoProvider {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let dataArr = (parent as? GLTaskDetailGPSViewController)?.dataArray {
            updateUI(dataArr: dataArr)
        }
    }
    
    func updateUI(dataArr: [GLSectionModel]) {
        dataArray = dataArr
        tableView.reloadData()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "基本信息")
    }
}


class GL评估信息ViewController: GLTaskDetailBaseViewController, IndicatorInfoProvider {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "评估信息")
    }
}

class GL风险控制ViewController: GLTaskDetailBaseViewController, IndicatorInfoProvider {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "风险控制")
    }
}

class GL尽职调查ViewController: GLTaskDetailBaseViewController, IndicatorInfoProvider {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "尽职调查")
    }
}

class GL合同签约ViewController: GLTaskDetailBaseViewController, IndicatorInfoProvider {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "合同签约")
    }
}

class GL资料附件ViewController: GLTaskDetailBaseViewController, IndicatorInfoProvider {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "资料附件")
    }
}

class GL费用及放款ViewController: GLTaskDetailBaseViewController, IndicatorInfoProvider {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "费用及放款")
    }
}


class GLTaskDetailGPSViewController: GLButtonBarPagerTabStripViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var typeButton: UIButton!
    
    @IBOutlet weak var topViewTopConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var submitBtn: DesignableButton!
    
    @IBOutlet weak var bottomViewBottomConstraint: NSLayoutConstraint!
    
    /// 列表cell模型
    var model: GLWorkTableModel?
    
    var dataArray: [GLSectionModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "任务详情"
//        settings.style.buttonBarItemLeftRightMargin = 8
        
        loadData()
    }
    
    func loadData() {
        
        let section1 = GLSectionModel(title: "订单信息", items: [GLItemModel(title: "所属门店", subTitle: "朝阳事业部"), GLItemModel(title: "所属门店", subTitle: "朝阳事业部"), GLItemModel(title: "所属门店", subTitle: "朝阳事业部")])
        
        let section2 = GLSectionModel(title: "车辆信息", items: [GLItemModel(title: "所属门店", subTitle: "朝阳事业部"), GLItemModel(title: "所属门店", subTitle: "朝阳事业部"), GLItemModel(title: "所属门店", subTitle: ""), GLItemModel(title: "所属门店", subTitle: ""), GLItemModel(title: "所属门店", subTitle: ""), GLItemModel(title: "所属门店", subTitle: "")])
        
        
        dataArray.append(section1)
        dataArray.append(section2)
        
        updateSubVcUI(dataArr: dataArray)
    }
    
    func updateSubVcUI(dataArr: [GLSectionModel]) {
        vc1.updateUI(dataArr: dataArr)
    }
    
    
    
    @IBAction func submitBtnClick(_ sender: DesignableButton) {
        
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        return [vc1, vc2, vc3, vc4, vc5, vc6, vc7]
    }
    
    lazy var vc1 = { () -> GL基本信息ViewController in
        return GL基本信息ViewController()
    }()
    
    lazy var vc2 = { () -> GL评估信息ViewController in
        return GL评估信息ViewController()
    }()
    
    lazy var vc3 = { () -> GL风险控制ViewController in
        return GL风险控制ViewController()
    }()
    
    lazy var vc4 = { () -> GL尽职调查ViewController in
        return GL尽职调查ViewController()
    }()
    
    lazy var vc5 = { () -> GL合同签约ViewController in
        return GL合同签约ViewController()
    }()
    
    lazy var vc6 = { () -> GL资料附件ViewController in
        return GL资料附件ViewController()
    }()
    
    lazy var vc7 = { () -> GL费用及放款ViewController in
        return GL费用及放款ViewController()
    }()
    
}

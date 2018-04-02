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
import SKPhotoBrowser


/// 条目展示的模型
struct GLItemModel: HandyJSON {
    var title = ""
    var subTitle = ""
    
}


/// 表格模型
struct GLFormModel: HandyJSON {
    var titles: [String] = []
    var dataArray: [[String]] = []
}


/// 图片模型
struct GLPictureModel: HandyJSON {
    var pictures: [String] = []
}


/// 数据层（组模型）
struct GLSectionModel: HandyJSON {
    var title = ""
    var items: [Any] = []
}



/// 区头部
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



/// 条目Cell
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


/// 表格cell
class GLTaskDetailFormCell: UITableViewCell, SheetViewDelegate, SheetViewDataSource {
    
    lazy var sheetView = { () -> SheetView in
       let sheet = SheetView()
        sheet.dataSource = self
        sheet.delegate = self
        sheet.sheetHead = "sheet"
        sheet.titleRowHeight = 33
        sheet.backgroundColor = .red
        return sheet
    }()
    
    var topArr: [String] = []
    var contentArr: [[String]] = []
    var leftArr: [String] = []
    
    var formModel: GLFormModel? {
        didSet {
            sheetView.sheetHead = formModel?.titles.first
            
            formModel?.titles.removeFirst()
            topArr = (formModel?.titles)!
            leftArr = (formModel?.dataArray)!.flatMap { (formItemModel) -> String? in
                return formItemModel.first
            }
            
            
            contentArr = (formModel?.dataArray)!.flatMap({ (strArr) -> [String]? in
                var strArr = strArr
                strArr.removeFirst()
                return strArr
            })
            
            
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(sheetView)
        sheetView.snp.remakeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.bottom.equalTo(self)
        }
        
    }
    
    
    func sheetView(sheetView: SheetView, numberOfRowsInSection section: Int) -> Int {
        return contentArr.count
    }
    
    func sheetView(sheetView: SheetView, numberOfColsInSection section: Int) -> Int {
        return topArr.count
    }
    
    func sheetView(sheetView: SheetView, cellForContentItemAtIndexRow indexRow: NSIndexPath?, indexCol: NSIndexPath?) -> String {
    
        let formArr = contentArr[indexRow!.row]
        
        return formArr[indexCol!.row]
        
    }
    
    func sheetView(sheetView: SheetView, cellForLeftColAtIndexPath indexPath: NSIndexPath?) -> String {
        return leftArr[indexPath!.row]
        
    }
    
    func sheetView(sheetView: SheetView, cellForTopRowAtIndexPath indexPath: NSIndexPath?) -> String {
        return topArr[indexPath!.row]
    }
    
    func sheetView(sheetView: SheetView, cellWithColorAtIndexRow indexRow: NSIndexPath?) -> Bool {
        return ((indexRow?.row)! % 2 == 1) ? true : false
    }
    
    func sheetView(sheetView: SheetView, heightForRowAtIndexPath indexPath: NSIndexPath?) -> CGFloat {
        return 33
    }
    
    func sheetView(sheetView: SheetView, widthForColAtIndexPath indexPath: NSIndexPath?) -> CGFloat {
        return (sheetView.frame.size.width - sheetView.titleColWidth) / 2
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func sheetView(sheetView: SheetView, cellDidSelectedAtIndexRow indexRow: NSIndexPath?, indexCol: NSIndexPath?) {
        print("点击 row \(String(describing: indexRow!.row)) col \(String(describing: indexCol!.row))")
    }
    
}




/// 图片整体TableViewCell
class GLTaskDetailTableViewPictureCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    fileprivate let identifier = "GLTaskDetailPictureCell"
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    var pictureArray = [SKPhoto]()
    private var observer: NSObjectProtocol?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        collectionView.register(UINib(nibName: "GLTaskDetailPictureCell", bundle: nil), forCellWithReuseIdentifier: identifier)
        
        observer = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: SKPHOTO_LOADING_DID_END_NOTIFICATION), object: nil, queue: OperationQueue.main, using: {[weak self] (noti) in
            guard let photo = noti.object as? SKPhoto else {return}
            let indexPath = IndexPath(item: photo.index, section: 0)
            self?.collectionView.reloadItems(at: [indexPath])
        })
        
    }
    
    deinit {
        guard let observer = observer else { return }
        NotificationCenter.default.removeObserver(observer)
    }
    
    
    /// 图片模型
    var pictureModel: GLPictureModel? {
        didSet{
            var arr = [SKPhoto]()
            pictureModel?.pictures.enumerated().forEach({ (index, value) in
                let photo = SKPhoto.photoWithImageURL(value)
                photo.checkCache()
                photo.index = index
                photo.shouldCachePhotoURLImage = true
                photo.loadUnderlyingImageAndNotify()
                arr.append(photo)
            })
            pictureArray = arr
            
            
            let count = (pictureModel?.pictures.count)!
            let constant = CGFloat((Int(count-1)/3)+1) * 100.0 - 10
            collectionViewHeight.constant = constant
            
            collectionView.reloadData()
        }
    }
    
    
    // MARK - collectionViewDelegate
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictureArray.count
    }
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        guard let pictureCell = cell as? GLTaskDetailPictureCell else {
            return UICollectionViewCell()
        }
        pictureCell.imageView.image = pictureArray[indexPath.item].underlyingImage
        return pictureCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? GLTaskDetailPictureCell else { return }
        
        guard let originImage = cell.imageView.image else { return } // some image for baseImage
        
        let browser = SKPhotoBrowser(originImage: originImage, photos: pictureArray, animatedFromView: cell)
        browser.initializePageIndex(indexPath.item)
        let vc = cell.viewController()
        vc?.present(browser, animated: true, completion: nil)
    }
    
}





/// 各个自模块控制器的父类控制器
class GLTaskDetailBaseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    open lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 8, y: 0, width: view.frame.size.width-16, height: view.frame.size.height), style: UITableViewStyle.grouped)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        tableView.estimatedRowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "GLTaskDetailItemHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: GLTaskDetailItemHeaderId)
        
        tableView.register(UINib(nibName: "GLTaskDetailItemCell", bundle: nil), forCellReuseIdentifier: GLTaskDetailItemCellId)
        
        tableView.register(GLTaskDetailFormCell.self, forCellReuseIdentifier: GLTaskDetailFormCellId)
        
        tableView.register(UINib(nibName: "GLTaskDetailTableViewPictureCell", bundle: nil), forCellReuseIdentifier: GLTaskDetailTableViewPictureCellId)
        
        tableView.contentInset = UIEdgeInsetsMake(8, 0, 0, 0)
        return tableView
    }()
    
    
    /// 重用标识符
    fileprivate let GLTaskDetailItemCellId = "GLTaskDetailItemCellId"
    fileprivate let GLTaskDetailItemHeaderId = "GLTaskDetailItemHeaderId"
    fileprivate let GLTaskDetailFormCellId = "GLTaskDetailFormCellId"
    fileprivate let GLTaskDetailTableViewPictureCellId = "GLTaskDetailTableViewPictureCellId"
    
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
        let sectionModel = dataArray[indexPath.section]
        let model = sectionModel.items[indexPath.row]
        
        if let itemModel = model as? GLItemModel {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GLTaskDetailItemCellId) as? GLTaskDetailItemCell else {
                return GLTaskDetailItemCell()
            }
            
            cell.itemModel = itemModel
            
            return cell
        }
        
        if let formModel = model as? GLFormModel {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GLTaskDetailFormCellId) as? GLTaskDetailFormCell else {
                return GLTaskDetailFormCell()
            }
            cell.formModel = formModel
            return cell
        }
        
        if let pictureModel = model as? GLPictureModel {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GLTaskDetailTableViewPictureCellId) as? GLTaskDetailTableViewPictureCell else {
                return GLTaskDetailTableViewPictureCell()
            }
            
            cell.pictureModel = pictureModel
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: GLTaskDetailItemHeaderId) as? GLTaskDetailItemHeader else {
            return GLTaskDetailItemHeader(reuseIdentifier: GLTaskDetailItemHeaderId)
        }
        sectionHeader.sectionModel = dataArray[section]
        
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionModel = dataArray[indexPath.section]
        let model = sectionModel.items[indexPath.row]
        if let model = model as? GLFormModel {
            return CGFloat((model.dataArray.count+1)*33)
        }
        
        return UITableViewAutomaticDimension
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





/// 二期GPS 下户 抵押 审批 框架控制器
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
    
    
    /// 加载数据 数据驱动
    func loadData() {
        
        let section1 = GLSectionModel(title: "订单信息", items: [GLItemModel(title: "所属门店", subTitle: "朝阳事业部"), GLItemModel(title: "所属门店", subTitle: "朝阳事业部"), GLItemModel(title: "所属门店", subTitle: "朝阳事业部"), GLItemModel(title: "所属门店", subTitle: "朝阳事业部"), GLItemModel(title: "所属门店", subTitle: "朝阳事业部"), GLItemModel(title: "所属门店", subTitle: "朝阳事业部"), GLItemModel(title: "所属门店", subTitle: "朝阳事业部"), GLItemModel(title: "所属门店", subTitle: "朝阳事业部"), GLItemModel(title: "所属门店", subTitle: "朝阳事业部")])
        
        
        let section2 = GLSectionModel(title: "车辆信息", items: [GLItemModel(title: "所属门店", subTitle: "朝阳事业部"), GLFormModel(titles: ["1", "2", "3", "3"], dataArray: [["好","世界","ss","ss"], ["你","世界","ff","ss"], ["你好","世界","呵呵","ss"]])])
        
        
        
        let section3 = GLSectionModel(title: "图片图片", items: [GLPictureModel(pictures: ["http://www.duanhan.ren/staticgfs/504810054c8949a49bf7b36896b18b4c.jpg", "http://www.duanhan.ren/staticgfs/504810054c8949a49bf7b36896b18b4c.jpg", "http://www.duanhan.ren/staticgfs/504810054c8949a49bf7b36896b18b4c.jpg", "http://www.duanhan.ren/staticgfs/504810054c8949a49bf7b36896b18b4c.jpg", "http://www.duanhan.ren/staticgfs/504810054c8949a49bf7b36896b18b4c.jpg", "http://www.duanhan.ren/staticgfs/504810054c8949a49bf7b36896b18b4c.jpg", "http://www.duanhan.ren/staticgfs/504810054c8949a49bf7b36896b18b4c.jpg"])])
        
        
        dataArray.append(section1)
        dataArray.append(section2)
        dataArray.append(section3)
        
        updateSubVcUI(dataArr: dataArray)
    }
    
    func updateSubVcUI(dataArr: [GLSectionModel]) {
        vc1.updateUI(dataArr: dataArr)
    }
    
    
    
    @IBAction func submitBtnClick(_ sender: DesignableButton) {
        
        // 安装GPS
//        guard let installGPSNaVc = UIStoryboard(name: "GLInstallGPS", bundle: nil).instantiateInitialViewController() else { return }
//        present(installGPSNaVc, animated: true, completion: nil)
        
        // 下户
//        guard let underHouseVc = UIStoryboard(name: "GLUnderhouse", bundle: nil).instantiateInitialViewController() else { return }
//        present(underHouseVc, animated: true, completion: nil)
        
        // 抵质押办理
        guard let pledgeVc = UIStoryboard(name: "GLPledge", bundle: nil).instantiateInitialViewController() else { return }
        present(pledgeVc, animated: true, completion: nil)
        
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

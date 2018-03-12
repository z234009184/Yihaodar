//
//  GLTaskDetailPriceViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/24.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring
import XLPagerTabStrip
import SnapKit
import SwiftyJSON
import HandyJSON
import SKPhotoBrowser


/**
 {
 "store_name": "朝阳事业部",
 "brand_name": "丰田",
 "series_name": "花冠",
 "style_name": "2004款 1.8L 自动GLX-S",
 "goods_code": "京A66666",
 "production_date": "2018-02-14",
 "register_date": "2018-02-20",
 "car_color": "在",
 "run_number": "12312",
 "displacement": "zeqw123",
 "peccancy": "1",
 "peccancy_fraction": "123",
 "peccancy_money": "123",
 "engine_code": "11",
 "frame_code": "123",
 "invoice": "123",
 "transfer_number": "123",
 "ower": "z ",
 "year_check": "2018-02-01",
 "jq_insurance": "2018-02-23",
 "sy_insurance": "2018-02-20",
 "assessment_name": "啧啧啧",
 "confirmed_money": 123123,
 "remarks": "12312331",
 "status_id": "02",
 "gearbox": "手动",
 "driving_type": "前驱",
 "keyless_startup": "有",
 "cruise_control": "有",
 "navigation": "有",
 "hpyl": "有",
 "chair_type": "手动",
 "fuel_type": "汽油",
 "skylight": "无",
 "air_conditioner": "手动",
 "other": "倒车影像",
 "accident": "水泡车",
 "boss_party_id": "海淀全07在想车你吗",
 "executive_party_id": "评估师09",
 "director_party_id": "蜡笔小新",
 "priceName": "啧啧啧"
 }
 */


/**
 {
 "remarks" : "",
 "parts_two_id" : "前保险杠",
 "parts_one_id" : "覆盖件",
 "id" : "000000006045273a016044cf87560017",
 "cust_request_id" : "f54599b9a84c42fd8807ef102ec48094",
 "accident_type" : "HH：划痕"
 }
 */

/// 车况

struct GLPriceCarStateModel: HandyJSON {
    var remarks: String?
    var parts_two_id: String?
    var parts_one_id: String?
    var id: String?
    var cust_request_id: String?
    var accident_type: String?
}

/*
 {
"file_name" : "661b1e8adbae43d395963c28054ae419.jpg",
"file_type_name" : "外观001",
"file_url" : "http:\/\/www.duanhan.ren\/staticgfs\/661b1e8adbae43d395963c28054ae419.jpg",
"file_size" : 21
}
*/

/// 定价详情图片模型
struct GLPricePictureModel: HandyJSON {
    var file_name: String?
    var file_type_name: String?
    var file_url: String?
    var file_size: String?
}

/// 定价结果模型
struct GLPriceResultModel: HandyJSON {
    var partyName: String?
    var confirmedMoney: String?
    var appraiseRemarks: String?
}

/// 定价模型
struct GLPriceAssessmentModel: HandyJSON {
    var fuel_type: String?
    var cruise_control: String?
    var store_name: String?
    var director_party_id: String?
    var boss_party_id: String?
    var run_number: String?
    var transfer_number: String?
    var series_name: String?
    var Accident_level: String?
    var jq_insurance: String?
    var status_id: String?
    var statusBtnTitle: String {
        guard let status_id = status_id else { return "无状态" }
        switch status_id {
        case "01":
            return "待提交"
        case "02":
            return "待定价"
        case "03":
            return "已定价"
        case "04":
            return "已失效"
        case "05":
            return "车辆评估（流程回退）"
        default:
            return "未知状态"
        }
    }
    
    var invoice: String?
    var engine_code: String?
    var assessment_name: String?
    var skylight: String?
    var production_date: String?
    var priceMoney: String?
    var navigation: String?
    var brand_name: String?
    var air_conditioner: String?
    var goods_code: String?
    var peccancy_money: String?
    var airbag: String?
    var insurance_due_date: String?
    var accident: String?
    var other: String?
    var style_name: String?
    var priceRemarks: String?
    var ower: String?
    var hpyl: String?
    var peccancy_fraction: String?
    var sy_insurance: String?
    var priceName: String?
    var confirmed_money: String?
    var remarks: String?
    var car_color: String?
    var peccancy: String?
    var gearbox: String?
    var frame_code: String?
    var year_check: String?
    var executive_party_id: String?
    var chair_type: String?
    var keyless_startup: String?
    var driving_type: String?
    var register_date: String?
    var displacement: String?
}


struct GLPriceDetailModel: HandyJSON {
    var attList0 = [GLPricePictureModel]()
    var attList1 = [GLPricePictureModel]()
    var attList2 = [GLPricePictureModel]()
    var attList3 = [GLPricePictureModel]()
    var attList4 = [GLPricePictureModel]()
    var parts: [GLPriceCarStateModel]?
    var priceList: [GLPriceResultModel]?
    var assessmentList: GLPriceAssessmentModel?
}




class GLBasicMessageViewController: UIViewController, IndicatorInfoProvider, UIScrollViewDelegate {
    static var parentVc: GLTaskDetailPriceViewController?
    // 订单信息
    @IBOutlet weak var orderStoreLabel: UILabel!
    @IBOutlet weak var orderManagerLabel: UILabel!
    @IBOutlet weak var orderSuperintendLabel: UILabel!
    @IBOutlet weak var orderMajordomoLabel: UILabel!
    
    
    // 车辆信息
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var carNumberLabel: UILabel!
    @IBOutlet weak var carSeriesLabel: UILabel!
    @IBOutlet weak var carColorLabel: UILabel!
    @IBOutlet weak var carProductDateLabel: UILabel!
    @IBOutlet weak var carRegisterDateLabel: UILabel!
    @IBOutlet weak var carMileageLabel: UILabel!
    @IBOutlet weak var carExhaustLabel: UILabel!
    @IBOutlet weak var carPeccancyLabel: UILabel!
    @IBOutlet weak var carEngineVersionLabel: UILabel!
    @IBOutlet weak var carFrameNumberLabel: UILabel!
    @IBOutlet weak var carInvoicePriceLabel: UILabel!
    
    @IBOutlet weak var carCheckLimitDateLabel: UILabel!
    
    @IBOutlet weak var carTrafficLabel: UILabel!
    
    @IBOutlet weak var carBusinessLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GLBasicMessageViewController.parentVc = parent as? GLTaskDetailPriceViewController
        
        
    }
    
    /// 更新界面
    public func updateUI(model: GLPriceDetailModel) {
        orderStoreLabel.text = model.assessmentList?.store_name
        orderManagerLabel.text = model.assessmentList?.boss_party_id?.isEmpty == false ? model.assessmentList?.boss_party_id : "未选择"
        orderSuperintendLabel.text = model.assessmentList?.executive_party_id?.isEmpty == false ? model.assessmentList?.executive_party_id : "未选择"
        orderMajordomoLabel.text = model.assessmentList?.director_party_id?.isEmpty == false ? model.assessmentList?.director_party_id : "未选择"
        
        carNameLabel.text = model.assessmentList?.ower
        carNumberLabel.text = model.assessmentList?.goods_code
        carSeriesLabel.text = model.assessmentList?.series_name
        carColorLabel.text = model.assessmentList?.car_color
        carProductDateLabel.text = model.assessmentList?.production_date
        carRegisterDateLabel.text = model.assessmentList?.register_date
        carMileageLabel.text = model.assessmentList?.run_number
        carExhaustLabel.text = model.assessmentList?.displacement
        carPeccancyLabel.text = (model.assessmentList?.peccancy)! == "0" ? "无" : "罚分:\(model.assessmentList?.peccancy_fraction ?? "0")(分)  罚款:\(model.assessmentList?.peccancy_money ?? "0")(元)"
        carEngineVersionLabel.text = model.assessmentList?.engine_code
        carFrameNumberLabel.text = model.assessmentList?.frame_code
        carInvoicePriceLabel.text = model.assessmentList?.invoice?.isEmpty == false ? model.assessmentList?.invoice : "未选择"
        carCheckLimitDateLabel.text = model.assessmentList?.year_check
        carTrafficLabel.text = model.assessmentList?.jq_insurance?.isEmpty == false ? model.assessmentList?.jq_insurance : "未选择"
        carBusinessLabel.text = model.assessmentList?.sy_insurance?.isEmpty == false ? model.assessmentList?.sy_insurance : "未选择"
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        
        if contentOffsetY <= 0 {
            GLBasicMessageViewController.parentVc!.topConstraint.constant = 0
        } else if contentOffsetY > 0 && contentOffsetY <= 65 {
            GLBasicMessageViewController.parentVc!.topConstraint.constant = -contentOffsetY
        } else {
            GLBasicMessageViewController.parentVc!.topConstraint.constant = -65
        }
    }
    // IndicatorInfoProvider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "基本信息")
    }
}
class GLEstimateMessageViewController: UIViewController, IndicatorInfoProvider, UIScrollViewDelegate {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var 车辆配置View: UIView!
    @IBOutlet weak var 评估结果View: UIView!
    @IBOutlet weak var 定价结果View: UIView!
    
    // 车辆配置
    @IBOutlet weak var 变速器Label: UILabel!
    @IBOutlet weak var 驱动方式Label: UILabel!
    @IBOutlet weak var 有无钥匙启动Label: UILabel!
    @IBOutlet weak var 定速巡航Label: UILabel!
    @IBOutlet weak var 导航Label: UILabel!
    @IBOutlet weak var 后排娱乐Label: UILabel!
    @IBOutlet weak var 座椅形式Label: UILabel!
    @IBOutlet weak var 燃油方式Label: UILabel!
    @IBOutlet weak var 天窗Label: UILabel!
    @IBOutlet weak var 空调配置Label: UILabel!
    @IBOutlet weak var 其他Label: UILabel!
    @IBOutlet weak var 事故Label: UILabel!
    
    
    /**
     车况信息动态获取添加
     */
    
    
    // 评估结果
    @IBOutlet weak var 评估师Label: UILabel!
    @IBOutlet weak var 评估价格Label: UILabel!
    @IBOutlet weak var 评估备注Label: UILabel!

    
    
    // 定价结果
    @IBOutlet weak var 定价师Label: UILabel!
    @IBOutlet weak var 定价价格Label: UILabel!
    @IBOutlet weak var 定价备注Label: UILabel!
    
    
    var carStateViews = [GLEstimateCarStateView]()
    var carStateDatas = [GLPriceCarStateModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let model = GLBasicMessageViewController.parentVc!.priceDetailModel {
            GLBasicMessageViewController.parentVc!.updateEstimateVcUI(priceDetailModel: model)
        }
        
        
    }
    
    /// 更新界面
    public func updateUI(model: GLPriceDetailModel) {
        if 变速器Label == nil { return }
        
        
        变速器Label.text = model.assessmentList?.gearbox
        驱动方式Label.text = model.assessmentList?.driving_type
        有无钥匙启动Label.text = model.assessmentList?.keyless_startup
        定速巡航Label.text = model.assessmentList?.cruise_control
        导航Label.text = model.assessmentList?.navigation
        后排娱乐Label.text = model.assessmentList?.hpyl
        座椅形式Label.text = model.assessmentList?.chair_type
        燃油方式Label.text = model.assessmentList?.fuel_type
        天窗Label.text = model.assessmentList?.skylight
        空调配置Label.text = model.assessmentList?.air_conditioner
        
        let other = model.assessmentList?.other?.isEmpty == false ? model.assessmentList?.other : "未选择"
        let airbag = model.assessmentList?.airbag?.isEmpty == false ? (model.assessmentList?.airbag)! + "个" : ""
        其他Label.text = other! + airbag
        事故Label.text = model.assessmentList?.accident?.isEmpty == false ? model.assessmentList?.accident : "未选择"
        
        
        评估师Label.text = model.assessmentList?.assessment_name
        评估价格Label.text = model.assessmentList?.confirmed_money
        评估备注Label.text = model.assessmentList?.remarks
        
        定价师Label.text = model.priceList?.first?.partyName?.isEmpty == false ? model.priceList?.first?.partyName : "未选择"
        定价价格Label.text = model.priceList?.first?.confirmedMoney?.isEmpty == false ? model.priceList?.first?.confirmedMoney : "未选择"
        定价备注Label.text = model.priceList?.first?.appraiseRemarks
        
        
        /// 布局 赋值车况信息
        guard let stateArr = model.parts else { return }
        carStateDatas = stateArr
        
        carStateViews.removeAll()
        for (index, value) in carStateDatas.enumerated() {
            let carStateView = Bundle.main.loadNibNamed("GLEstimateCarStateView", owner: nil, options: nil)?.first as! GLEstimateCarStateView
            contentView.addSubview(carStateView)
            carStateViews.append(carStateView)
            
            /// 布局
            if index == 0 {
                carStateView.snp.remakeConstraints { (make) in
                    make.top.equalTo(车辆配置View.snp.bottom).offset(10)
                    make.left.equalTo(contentView).offset(10)
                    make.right.equalTo(contentView).offset(-10)
                    make.height.equalTo(458).priority(249)
                }
            } else {
                let lastCarStateView = carStateViews[index-1]
                carStateView.snp.remakeConstraints { (make) in
                    make.top.equalTo(lastCarStateView.snp.bottom).offset(10)
                    make.left.equalTo(lastCarStateView)
                    make.right.equalTo(lastCarStateView)
                    make.height.equalTo(458).priority(249)
                }
            }
            
            if (index == carStateDatas.count - 1) {
                评估结果View.snp.updateConstraints { (make) in
                    make.top.equalTo(carStateView.snp.bottom).offset(10)
                }
            }
            
            
            // 赋值
            carStateView.partOneLabel.text = value.parts_one_id
            carStateView.partTwoLabel.text = value.parts_two_id
            carStateView.descLabel.text = value.accident_type
            carStateView.remarksLabel.text = value.remarks
        }
        
        
        guard let status_id = model.assessmentList?.status_id else { return }
        if status_id != "03" { // 如果不是已定价 就隐藏定价模块
            定价结果View.snp.remakeConstraints { (make) in
                make.height.equalTo(0)
            }
            定价结果View.isHidden = true
        }

    }
    
    
    // IndicatorInfoProvider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "评估信息")
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        
        if contentOffsetY <= 0 {
            GLBasicMessageViewController.parentVc!.topConstraint.constant = 0
        } else if contentOffsetY > 0 && contentOffsetY <= 65 {
            GLBasicMessageViewController.parentVc!.topConstraint.constant = -contentOffsetY
        } else {
            GLBasicMessageViewController.parentVc!.topConstraint.constant = -65
        }
    }
    
}




/// 图片附件控制器
class GLPictureMessageViewController: UIViewController, IndicatorInfoProvider, UIScrollViewDelegate {
    
    @IBOutlet weak var firstCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var firsrCollectionView: UICollectionView!
    var firstDataArray = NSMutableArray()
    
    @IBOutlet weak var secondCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var secondCollectionView: UICollectionView!
    var secondDataArray = NSMutableArray()
    
    @IBOutlet weak var thirdCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var thirdCollectionView: UICollectionView!
    var thirdDataArray = NSMutableArray()
    
    @IBOutlet weak var fourCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var fourCollectionView: UICollectionView!
    var fourDataArray = NSMutableArray()
    
    @IBOutlet weak var fiveCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var fiveCollectionView: UICollectionView!
    var fiveDataArray = NSMutableArray()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SKPhotoBrowserOptions.displayCounterLabel = false                         // counter label will be hidden
        SKPhotoBrowserOptions.displayCloseButton = false
        SKPhotoBrowserOptions.displayBackAndForwardButton = false
        SKPhotoBrowserOptions.displayStatusbar = true
        SKPhotoBrowserOptions.displayAction = false                               // action button will be hidden
        SKPhotoBrowserOptions.displayHorizontalScrollIndicator = true
        SKPhotoBrowserOptions.displayVerticalScrollIndicator = false
        SKPhotoBrowserOptions.enableSingleTapDismiss = true
        SKPhotoBrowserOptions.bounceAnimation = true
        SKPhotoBrowserOptions.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        SKCaptionOptions.textColor = .clear
        
        if let model = GLBasicMessageViewController.parentVc!.priceDetailModel {
            GLBasicMessageViewController.parentVc!.updatePictureVcUI(priceDetailModel: model)
        }
        
        
        
    }
    
    
    
    /// 更新界面
    public func updateUI(model: GLPriceDetailModel) {
        if firsrCollectionView == nil { return }
        
        updateCollection(dataArray: model.attList0, collectionView: firsrCollectionView, collectionViewHeight: firstCollectionViewHeight, photoDataArray: firstDataArray)
        updateCollection(dataArray: model.attList1, collectionView: secondCollectionView, collectionViewHeight: secondCollectionViewHeight, photoDataArray: secondDataArray)
        updateCollection(dataArray: model.attList2, collectionView: thirdCollectionView, collectionViewHeight: thirdCollectionViewHeight, photoDataArray: thirdDataArray)
        updateCollection(dataArray: model.attList3, collectionView: fourCollectionView, collectionViewHeight: fourCollectionViewHeight, photoDataArray: fourDataArray)
        updateCollection(dataArray: model.attList4, collectionView: fiveCollectionView, collectionViewHeight: fiveCollectionViewHeight, photoDataArray: fiveDataArray)

    }
    
    
    func updateCollection(dataArray: [GLPricePictureModel], collectionView: UICollectionView, collectionViewHeight: NSLayoutConstraint, photoDataArray: NSMutableArray) -> Void {
        // 布局collectionView height
        
        let count = dataArray.count - 1
        let constant: CGFloat = CGFloat((Int(count)/3)+1) * 100.0 - 10
        collectionViewHeight.constant = constant
        if count == -1 {
            collectionView.isHidden = true;
            collectionViewHeight.constant = 24.0
            return
        }
        
        photoDataArray.removeAllObjects()
        dataArray.enumerated().forEach({ (index, value) in
            let photo = SKPhoto.photoWithImageURL((value.file_url)!)
            photo.checkCache()
            if (collectionView == firsrCollectionView) {
                photo.caption = "first"
            } else if (collectionView == secondCollectionView) {
                photo.caption = "second"
            } else if (collectionView == thirdCollectionView) {
                photo.caption = "third"
            } else if (collectionView == fourCollectionView) {
                photo.caption = "four"
            } else {
                photo.caption = "five"
            }
            photo.index = index
            photo.shouldCachePhotoURLImage = true
            photo.loadUnderlyingImageAndNotify()
            photoDataArray.add(photo)
        })
        NotificationCenter.default.addObserver(self, selector: #selector(GLPictureMessageViewController.loadPicture(noti:)), name: NSNotification.Name(rawValue: SKPHOTO_LOADING_DID_END_NOTIFICATION), object: nil)
        collectionView.reloadData()
        
    }
    
    
    @objc func loadPicture(noti: NSNotification) -> Void {
        guard let photo = noti.object as? SKPhoto else {return}
        guard let caption = photo.caption else { return }
        if caption == "first" {
            let indexPath = IndexPath(item: photo.index, section: 0)
            firsrCollectionView.reloadItems(at: [indexPath])
        }
        if caption == "second" {
            let indexPath = IndexPath(item: photo.index, section: 0)
            secondCollectionView.reloadItems(at: [indexPath])
        }
        if caption == "third" {
            let indexPath = IndexPath(item: photo.index, section: 0)
            thirdCollectionView.reloadItems(at: [indexPath])
        }
        if caption == "four" {
            let indexPath = IndexPath(item: photo.index, section: 0)
            fourCollectionView.reloadItems(at: [indexPath])
        }
        if caption == "five" {
            let indexPath = IndexPath(item: photo.index, section: 0)
            fiveCollectionView.reloadItems(at: [indexPath])
        }
    }
    
    
    // IndicatorInfoProvider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "附件信息")
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        
        if contentOffsetY <= 0 {
            GLBasicMessageViewController.parentVc!.topConstraint.constant = 0
        } else if contentOffsetY > 0 && contentOffsetY <= 65 {
            GLBasicMessageViewController.parentVc!.topConstraint.constant = -contentOffsetY
        } else {
            GLBasicMessageViewController.parentVc!.topConstraint.constant = -65
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.removeObserver(self)
        print("priceDetailVc was deinit")
    }
}

fileprivate let identifier = "GLTaskDetailPictureCell"
extension GLPictureMessageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case firsrCollectionView:
            return firstDataArray.count
            
        case secondCollectionView:
            return secondDataArray.count
            
        case thirdCollectionView:
            return thirdDataArray.count
            
        case fourCollectionView:
            return fourDataArray.count
            
        case fiveCollectionView:
            return fiveDataArray.count
            
        default:
            return 0
            
        }
    }
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let pictureCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? GLTaskDetailPictureCell else {
            return UICollectionViewCell()
        }
        
        
        switch collectionView {
        case firsrCollectionView:
            pictureCell.imageView.image = (firstDataArray[indexPath.item] as! SKPhoto).underlyingImage
            break
        case secondCollectionView:
            pictureCell.imageView.image = (secondDataArray[indexPath.item] as! SKPhoto).underlyingImage
            break
        case thirdCollectionView:
            pictureCell.imageView.image = (thirdDataArray[indexPath.item] as! SKPhoto).underlyingImage
            break
        case fourCollectionView:
            pictureCell.imageView.image = (fourDataArray[indexPath.item] as! SKPhoto).underlyingImage
            break
        case fiveCollectionView:
            pictureCell.imageView.image = (fiveDataArray[indexPath.item] as! SKPhoto).underlyingImage
            break
        default:
            break
        }
        return pictureCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? GLTaskDetailPictureCell else { return }
        
        guard let originImage = cell.imageView.image else { return } // some image for baseImage
        
        var dataArr = [SKPhoto]()
        switch collectionView {
        case firsrCollectionView:
            dataArr = firstDataArray as! [SKPhoto]
            break
        case secondCollectionView:
            dataArr = secondDataArray as! [SKPhoto]
            break
        case thirdCollectionView:
            dataArr = thirdDataArray as! [SKPhoto]
            break
        case fourCollectionView:
            dataArr = fourDataArray as! [SKPhoto]
            break
        case fiveCollectionView:
            dataArr = fiveDataArray as! [SKPhoto]
            break
        default:
            break
        }
        
        let browser = SKPhotoBrowser(originImage: originImage, photos: dataArr, animatedFromView: cell)
        browser.initializePageIndex(indexPath.item)
        present(browser, animated: true, completion: nil)
        
    }
}









class GLTaskDetailPriceViewController: ButtonBarPagerTabStripViewController {
    
    
    @IBOutlet weak var bottomViewBottomConstrain: NSLayoutConstraint!
    
    
    @IBOutlet weak var priceTitleLabel: UILabel!
    @IBOutlet weak var priceStoreNameLabel: UILabel!
    @IBOutlet weak var priceStateBtn: UIButton!
    
    
    
    /// 列表cell模型
    var model: GLWorkTableModel?
    
    /// 详情模型
    var priceDetailModel: GLPriceDetailModel? {
        didSet {
            priceTitleLabel.text = model?.executionId
            priceStoreNameLabel.text = priceDetailModel?.assessmentList?.store_name
            
            priceStateBtn.setTitle(priceDetailModel?.assessmentList?.statusBtnTitle, for: .normal)
            
            if let status_id = priceDetailModel?.assessmentList?.status_id {
                if status_id == "03" {
                    bottomViewBottomConstrain.constant = -64
                    guard let money = priceDetailModel?.priceList?.first?.confirmedMoney else { return }
                    
                    priceStateBtn.setTitle("定价:" + money + "万元", for: .normal)
                    priceStateBtn.setTitleColor(YiBlueColor, for: .normal)
                    priceStateBtn.backgroundColor = .white
                    
                }
            }
            
        }
    }
    
    var basicVc: GLBasicMessageViewController?
    var estimateVc: GLEstimateMessageViewController?
    var pictureVc: GLPictureMessageViewController?
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    var refreshClosure: (()->())?
    
    override func viewDidLoad() {
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
        
        navigationItem.title = "任务详情"
        
        loadData()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        if #available(iOS 11.0, *) {
            super.viewSafeAreaInsetsDidChange()
        } else {
            // Fallback on earlier versions
        }
    }
    
    /// 加载定价详情数据
    func loadData() -> Void {
        guard let model = model else {
            return
        }
        
        GLProvider.request(GLService.priceDetail(custRequestId: model.executionId!, takeStatus: model.takeStatus!, partyId: GLUser.partyId!, processExampleId: model.processId!, processTaskId: model.processTaskId!)) {[weak self] (result) in
            
            if case let .success(respon) = result {
                print(JSON(respon.data))
                if JSON(respon.data)["type"] == "E" {
                    self?.navigationController?.popViewController(animated: true)
                }
                
                let jsonStr = JSON(respon.data).rawString()
                self?.priceDetailModel = GLPriceDetailModel.deserialize(from: jsonStr, designatedPath: "results")
                
                /// 更新子控制器UI
                if let priceDetailModel = self?.priceDetailModel {
                    self?.updateBasicVcUI(priceDetailModel: priceDetailModel)
                    self?.updateEstimateVcUI(priceDetailModel: priceDetailModel)
                    self?.updatePictureVcUI(priceDetailModel: priceDetailModel)
                }
            }
        }
    }
    
    func updateBasicVcUI(priceDetailModel: GLPriceDetailModel) -> Void {
        basicVc?.updateUI(model: priceDetailModel)
    }
    func updateEstimateVcUI(priceDetailModel: GLPriceDetailModel) -> Void {
        estimateVc?.updateUI(model: priceDetailModel)
    }
    func updatePictureVcUI(priceDetailModel: GLPriceDetailModel) -> Void {
        pictureVc?.updateUI(model: priceDetailModel)
    }
    
    /// 提交定价
    @IBAction func estimateBtnClick(_ sender: DesignableButton) {
        
        let showMsgView = showSubmitMessageView()
        
        
        weak var weakShowMsgView = showMsgView
        showMsgView.submitBtnClosure = { [weak self] in
            
            // 判断过滤
            let priceText = weakShowMsgView?.priceTextField.text ?? ""
            let remarksText = weakShowMsgView?.remarksLabel.text ?? ""
            if priceText.count < 1 {
                weakShowMsgView?.makeToast("请输入价格")
                return
            }
            
            
            self?.tabBarVc.dismissCover(btn: nil)
            self?.tabBarVc.showLoadingView(img: #imageLiteral(resourceName: "taskdetail_submit_loading"), title: "提交中...")
            GLProvider.request(GLService.submitPriceDetail(custRequestId: (self?.model?.executionId)!, partyName: GLUser.partyName!, processId: (self?.model?.processId)!, processTaskId: (self?.model?.processTaskId)!, confirmedMoney: priceText, appraiseRemarks: remarksText)) { (result) in
                if case let .success(respon) = result {
                    if JSON(respon.data)["type"] == "S" {
                        self?.tabBarVc.showLoadingView(img: #imageLiteral(resourceName: "taskdetail_submit_success"), title: "提交成功")
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                            self?.tabBarVc.dismissCover(btn: nil)
                            self?.navigationController?.popViewController(animated: true)
                            guard let refreshClosure = self?.refreshClosure else { return }
                            refreshClosure()
                        })
                    } else {
                        self?.tabBarVc.showLoadingView(img: #imageLiteral(resourceName: "taskdetail_submit_failure"), title: "提交失败")
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                            self?.tabBarVc.dismissCover(btn: nil)
                        })
                    }
                }
            }
        }
    }
    
    
    
    
    lazy var tabBarVc = tabBarController as! GLTabBarController
    lazy var submitMessageView: GLSubmitMessagePriceView = {
        let accessoryView = Bundle(for: GLTaskDetailPriceViewController.self).loadNibNamed("GLSubmitMessagePriceView", owner: nil, options: nil)?.first as! GLSubmitMessagePriceView
        let width = view.bounds.width
        let height = width * 190.0/375.0
        accessoryView.frame.size = CGSize(width: width, height: height)
        accessoryView.frame.origin.x = 0
        
        return accessoryView
    }()
    
    func showSubmitMessageView() -> GLSubmitMessagePriceView {
        let mask = tabBarVc.showMaskView()
        guard let maskView = mask else {
            return submitMessageView
        }
        submitMessageView.frame.origin.y = maskView.frame.size.height
        maskView.addSubview(submitMessageView)
        
        UIView.animate(withDuration: 0.25) {
            self.submitMessageView.frame.origin.y = maskView.frame.size.height - self.submitMessageView.frame.size.height
        }
        return submitMessageView
    }
    
    /// PagerTabStripDataSource
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        basicVc = UIStoryboard(name: "GLTaskDetailPrice", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLBasicMessageViewController") as? GLBasicMessageViewController
        estimateVc = UIStoryboard(name: "GLTaskDetailPrice", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLEstimateMessageViewController") as? GLEstimateMessageViewController
        pictureVc = UIStoryboard(name: "GLTaskDetailPrice", bundle: Bundle.main).instantiateViewController(withIdentifier: "GLPictureMessageViewController") as? GLPictureMessageViewController
        
        return [basicVc!, estimateVc!, pictureVc!]
    }
}

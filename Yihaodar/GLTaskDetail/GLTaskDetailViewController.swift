//
//  GLTaskDetailViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/7.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring
import SwiftyJSON
import SKPhotoBrowser
import SnapKit
import HandyJSON


/*
 // 极速
{
    "custId": "YHD-BD-CD-20171214-0001",
    "custRequestId": "",
    "vehicles": [
    {
    "fileTitle": "车辆驾驶证/机动车登记证书",
    "fileName": "4b0f0de323d84f5d801a60ee89871728.jpg",
    "uuid": "01201712141304073900",
    "fileUrl": "http://www.duanhan.ren/staticgfs/4b0f0de323d84f5d801a60ee89871728.jpg"
    },
    {
    "fileTitle": "其他附件",
    "fileName": "d929b94352a74e11bdc69a8297856c68.jpg",
    "uuid": "01201712141304073912",
    "fileUrl": "http://www.duanhan.ren/staticgfs/d929b94352a74e11bdc69a8297856c68.jpg"
    }
    ],
    "others": "[{"fileUrl":"http: //www.duanhan.ren/staticgfs/d929b94352a74e11bdc69a8297856c68.jpg","fileName":"d929b94352a74e11bdc69a8297856c68.jpg"}]",
    "bDType": "2",
    "createdDate": "2017年12月14日 17:29:54",
    "quotesId": "yhd_wap000022"
}

 // 手动
{
    "custId": "YHD-BD-CD-20171214-0002",
    "custRequestId": "",
    "isBj": "0",
    "goodsSeries": "23562",
    "brandName": "117",
    "registerTime": "2012",
    "quotesId": "yhd_wap000022",
    "goodsSeriesName": "2015款 ACS3 sport",
    "runNumber": "",
    "parValue": "",
    "brandNameCN": "AC Schnitzer",
    "brandSeriesName": "AC Schnitzer M3",
    "bDType": "1",
    "createdDate": "2017年12月14日 17:30:17",
    "carColor": "",
    "brandSeries": "3895"
}
*/

/// 评估信息模型
struct GLEstimateMsgModel: HandyJSON {
    var worth_id: String?
    var org_name: String?
    var created_date_long: String?
    var last_update_date_long: String?
    var evaluat_status: String?
    var cust_request_id: String?
    var party_id: String?
    var created_date: String?
    var party_name: String?
    var process_id: String?
    var last_update_date: String?
    var org_id: String?
    var store_id: String?
    var store_name: String?
    var dep_id: String?
    var dep_name: String?
    var confirmed_date: String?
    var confirmed_money: String?
    var car_info: String?
    var remarks: String?
    
}

/// 极速保单图片模型
struct GLTaskDetailPictureModel: HandyJSON {
    var fileTitle: String?
    var fileName: String?
    var uuid: String?
    var fileUrl: String?
    
}

/// 报单详情模型
struct GLTaskDetailModel: HandyJSON {
    var custId: String?
    var custRequestId: String?
    var isBj: String?
    var goodsSeries: String?
    var brandName: String?
    var registerTime: String?
    var quotesId: String?
    var goodsSeriesName: String?
    var runNumber: String?
    var parValue: String?
    var brandNameCN: String?
    var brandSeriesName: String?
    var bDType: String?
    var createdDate: String?
    var carColor: String?
    var brandSeries: String?
    var vehicles: [GLTaskDetailPictureModel]?
    var others: GLTaskDetailPictureModel?
}




class GLTaskDetailViewController: UIViewController {
    
    /// 报单信息 --------------------
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var orderPersonLabel: UILabel!
    @IBOutlet weak var orderSubmitDateLabel: UILabel!
    
         // 手动保单视图
    @IBOutlet weak var manualView: UIView!
    
    @IBOutlet weak var orderCarBrandlabel: UILabel!
    @IBOutlet weak var orderCarYearLabel: UILabel!
    @IBOutlet weak var orderMileageLabel: UILabel!
    @IBOutlet weak var orderBigMoneyLabel: UILabel!
    @IBOutlet weak var orderCarColorLabel: UILabel!
    @IBOutlet weak var orderIsBeiJingNumberLabel: UILabel!
    
    
         // 极速保单
    @IBOutlet weak var speedView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    /// 评估信息 ---------------------
    @IBOutlet weak var estimateMsgView: DesignableView!
    @IBOutlet weak var estimateMsgViewTop: NSLayoutConstraint!
    
    @IBOutlet weak var estimateDateLabel: UILabel!
    @IBOutlet weak var estimatePriceLabel: UILabel!
    @IBOutlet weak var estimateCarDetailMsgLabel: UILabel!
    @IBOutlet weak var estimateMemoLabel: UILabel!
    
    /// 过期失效视图
    @IBOutlet weak var invalidView: UIView!
    @IBOutlet weak var invalidDateLabel: UILabel!
    
    
    /// 底部评估视图
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var estimateButton: DesignableButton!
    
    @IBOutlet weak var bottomViewBottom: NSLayoutConstraint!
    
    /// 列表cell模型
    var model: GLWorkTableModel?
    
    /// 详情模型
    var detailModel: GLTaskDetailModel? {
        didSet{
            
            orderNumberLabel.text = detailModel?.custId
            orderPersonLabel.text = detailModel?.quotesId
            orderSubmitDateLabel.text = detailModel?.createdDate
            
            if detailModel?.bDType == "1" { // 手动报单
                speedView.isHidden = true
                manualView.isHidden = false
                speedView.snp.remakeConstraints({ (make) in
                    make.height.equalTo(0)
                })
                manualView.snp.removeConstraints()
                
                orderCarBrandlabel.text = (detailModel?.brandNameCN)! + " " + (detailModel?.brandSeriesName)! + " " + (detailModel?.goodsSeriesName)!
                
                if detailModel?.registerTime?.isEmpty == false {
                    orderCarYearLabel.text = (detailModel?.registerTime)! + "年"
                } else {
                    orderCarYearLabel.text = "未填写"
                    orderCarYearLabel.textColor = YiUnselectedTitleColor
                }
                
                
                if detailModel?.runNumber?.isEmpty == false {
                    orderMileageLabel.text = (detailModel?.runNumber)! + "公里"
                } else {
                    orderMileageLabel.text = "未填写"
                    orderMileageLabel.textColor = YiUnselectedTitleColor
                }
                
                if detailModel?.parValue?.isEmpty == false {
                    orderBigMoneyLabel.text = (detailModel?.parValue)!.decimalString() + "元"
                } else {
                    orderBigMoneyLabel.text = "未填写"
                    orderBigMoneyLabel.textColor = YiUnselectedTitleColor
                }
                
                if detailModel?.carColor?.isEmpty == false {
                    orderCarColorLabel.text = detailModel?.carColor
                } else {
                    orderCarColorLabel.text = "未填写"
                    orderCarColorLabel.textColor = YiUnselectedTitleColor
                }
                
                if detailModel?.isBj?.isEmpty == false {
                    orderIsBeiJingNumberLabel.text = detailModel?.isBj == "0" ? "是" : "否"
                } else {
                    orderIsBeiJingNumberLabel.text = "未填写"
                }
                
            } else if detailModel?.bDType == "2" { // 极速报单
                speedView.isHidden = false
                manualView.isHidden = true
                speedView.snp.removeConstraints()
                manualView.snp.remakeConstraints({ (make) in
                    make.height.equalTo(0)
                })
                
                
                detailModel?.vehicles?.enumerated().forEach({ (index, value) in
                    let photo = SKPhoto.photoWithImageURL((value.fileUrl)!)
                    photo.checkCache()
                    photo.index = index
                    photo.shouldCachePhotoURLImage = true
                    photo.loadUnderlyingImageAndNotify()
                    imagesss.append(photo)
                })
                
                
                
                observer = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: SKPHOTO_LOADING_DID_END_NOTIFICATION), object: nil, queue: OperationQueue.main, using: {[weak self] (noti) in
                    guard let photo = noti.object as? SKPhoto else {return}
                    let indexPath = IndexPath(item: photo.index, section: 0)
                    self?.collectionView.reloadItems(at: [indexPath])
                })
                
                
                
                let count = (detailModel?.vehicles?.count)! - 1
                let constant = CGFloat((Int(count)/3)+1) * 100.0 - 10
                collectionViewHeight.constant = constant
                
                collectionView.reloadData()
            }
        }
    }
    
    /// 评估信息模型
    var estimateMsgModel: GLEstimateMsgModel? {
        didSet{
            guard let estimateMsgModel = estimateMsgModel else { return }
            guard let evaluat_status = estimateMsgModel.evaluat_status else { return }
            if evaluat_status == "1" || evaluat_status == "2" { // 已评估
                
                if evaluat_status == "2" { // 已失效
                    invalidView.isHidden = false
                    if let str = estimateMsgModel.last_update_date {
                        invalidDateLabel.text = str.substring(to: str.index(str.startIndex, offsetBy: 10))
                    }
                } else { // 未失效
                    invalidView.isHidden = true
                }
                bottomView.isHidden = true
                bottomViewBottom.constant = 64
                estimateMsgView.isHidden = false
                estimateMsgView.snp.removeConstraints()
                
                estimateDateLabel.text = estimateMsgModel.confirmed_date
                estimatePriceLabel.text = (estimateMsgModel.confirmed_money)!.decimalString() + "万元"
                if estimateMsgModel.car_info?.isEmpty == false {
                    estimateCarDetailMsgLabel.text = estimateMsgModel.car_info
                } else {
                    estimateCarDetailMsgLabel.text = "未填写"
                    estimateCarDetailMsgLabel.textColor = YiUnselectedTitleColor
                }
                
                if estimateMsgModel.remarks?.isEmpty == false {
                    estimateMemoLabel.text = estimateMsgModel.remarks
                } else {
                    estimateMemoLabel.text = "未填写"
                    estimateMemoLabel.textColor = YiUnselectedTitleColor
                }
                
                
            } else { // 未评估
                bottomView.isHidden = false
                bottomViewBottom.constant = 0
                estimateMsgView.isHidden = true
                estimateMsgView.snp.remakeConstraints({ (make) in
                    make.height.equalTo(0)
                })
                
            }
        }
    }
    
    
    var imagesss = [SKPhoto]()
    var observer: NSObjectProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "任务详情"
        
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
        
    
        loadData()
    }
    
    func loadData() -> Void {
        guard let model = model else {
            return
        }
        
        GLProvider.request(GLService.estimateDetail(custRequestId: model.executionId!, takeStatus: model.takeStatus!, partyId: GLUser.partyId!, processExampleId: model.processId!, processTaskId: model.processTaskId!)) {[weak self] (result) in
            
            if case let .success(respon) = result {
                print(JSON(respon.data))
                
                
                let jsonStr = JSON(respon.data).rawString(options: [])
                
                self?.detailModel = GLTaskDetailModel.deserialize(from: jsonStr, designatedPath: "results.dataDJ")
                self?.estimateMsgModel = GLEstimateMsgModel.deserialize(from: jsonStr, designatedPath: "results.dataPG")
                
                if JSON(respon.data)["type"] == "E" {
                    NotificationCenter.default.post(name: YiSubmitSuccessNotificationName, object: nil)
                    self?.navigationController?.popViewController(animated: true)
                }
                
            }
        }
    }
    
    
    
    
    lazy var tabBarVc = tabBarController as! GLTabBarController
    
    lazy var submitMessageView: GLSubmitMessageView = {
        let accessoryView = GLSubmitMessageView()
        let width = view.bounds.width
        let height = width * 238.0/375.0
        accessoryView.frame.size = CGSize(width: width, height: height)
        accessoryView.frame.origin.x = 0
        
        
        return accessoryView
    }()
    
    func showSubmitMessageView() -> GLSubmitMessageView {
        let mask = tabBarVc.showMaskView()
        guard let maskView = mask else {
            return submitMessageView
        }
        submitMessageView.frame.origin.y = maskView.frame.size.height
        maskView.addSubview(submitMessageView)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.submitMessageView.frame.origin.y = maskView.frame.size.height - self.submitMessageView.frame.size.height
        }) { (b) in
            print(b)
            self.submitMessageView.priceTextField.becomeFirstResponder()
        }
        return submitMessageView
    }
    
    
    
    
    
    /// 提交评估
    @IBAction func estimateBtnClick(_ sender: DesignableButton) {
        let showMsgView = showSubmitMessageView()
        
        
        weak var weakShowMsgView = showMsgView
        showMsgView.submitBtnClosure = { [weak self] in
            
            // 判断过滤
            let priceText = weakShowMsgView?.priceTextField.text ?? ""
            let carMsgText = weakShowMsgView?.carMsgTextField.text ?? ""
            let remarksText = weakShowMsgView?.memoTextField.text ?? ""
            if priceText.count < 1 {
                weakShowMsgView?.makeToast("请输入价格")
                return
            }
            
            
            
            self?.tabBarVc.dismissCover(btn: nil)
            self?.tabBarVc.showLoadingView(img: #imageLiteral(resourceName: "taskdetail_submit_loading"), title: "提交中...")
            let brand = self?.detailModel?.brandSeriesName ?? ""
            let series = self?.detailModel?.goodsSeriesName ?? ""
            let carBrandSeries = brand + series
            
            GLProvider.request(GLService.submitTaskDetail(partyId: GLUser.partyId!, processId: (self?.model?.processId)!, processTaskId: (self?.model?.processTaskId)!, executionId: (self?.model?.executionId)!, confirmedMoney: priceText, remarks: remarksText, carInfo: carMsgText, carType: carBrandSeries), completion: { (result) in
                if case let .success(respon) = result {
                    print(JSON(respon.data))
                    if JSON(respon.data)["type"] == "S" {
                        self?.tabBarVc.showLoadingView(img: #imageLiteral(resourceName: "taskdetail_submit_success"), title: "提交成功")
                        NotificationCenter.default.post(name: YiSubmitSuccessNotificationName, object: nil)
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                            self?.tabBarVc.dismissCover(btn: nil)
                            self?.navigationController?.popViewController(animated: true)
                        })
                    } else {
                        self?.tabBarVc.showLoadingView(img: #imageLiteral(resourceName: "taskdetail_submit_failure"), title: "提交失败")
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                            self?.tabBarVc.dismissCover(btn: nil)
                        })
                    }
                } else {
                    self?.tabBarVc.dismissCover(btn: nil)
                }
            })
            
        }
        
    }
    
    
    deinit {
        guard let observer = observer else { return }
        NotificationCenter.default.removeObserver(observer)
    }
    
    
}



class GLTaskDetailPictureCell: UICollectionViewCell {
    
    @IBOutlet weak var deleteBtn: UIButton!
    var deleteClosure: ((GLTaskDetailPictureCell)->())?
    
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func deleteBtnClick(_ sender: UIButton) {
        if let deleteClosure = deleteClosure {
            deleteClosure(self)
        }
    }
}



fileprivate let identifier = "GLTaskDetailPictureCell"
extension GLTaskDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imagesss.count
    }
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        guard let pictureCell = cell as? GLTaskDetailPictureCell else {
            return UICollectionViewCell()
        }
        pictureCell.imageView.image = imagesss[indexPath.item].underlyingImage
        return pictureCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? GLTaskDetailPictureCell else { return }
        
        guard let originImage = cell.imageView.image else { return } // some image for baseImage
        
        let browser = SKPhotoBrowser(originImage: originImage, photos: imagesss, animatedFromView: cell)
        browser.initializePageIndex(indexPath.item)
        present(browser, animated: true, completion: nil)
        
    }
}

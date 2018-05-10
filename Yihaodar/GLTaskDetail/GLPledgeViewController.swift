//
//  GLPledgeViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/3/30.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring
import IQKeyboardManagerSwift
import HandyJSON
import SwiftyJSON
import Moya
import JGProgressHUD


class GLPledgeViewController: UIViewController {
    
    @IBOutlet weak var pledgeDate: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    private lazy var pictureArray: [GLPauperInfoModel.GLAttachmentModel] = {
        var arr: [GLPauperInfoModel.GLAttachmentModel] = []
        let ccroModel = GLPauperInfoModel.GLAttachmentModel()
        arr.append(ccroModel)
        return arr
    }()
    
    var model: GLWorkTableModel?
    var submitSuccess: (()->())?
    
    var pledgeModel: GLCompleteModel.GLPledgeModel.GLPledgeInfoModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkBackGPSProcess()
        
    }
    
    
    /// 查询回退流程
    func checkBackGPSProcess() {
        view.showLoading()
        GLProvider.request(GLService.backPledgeProcess(l_number: (model?.executionId)!), completion: { [weak self] (result) in
            self?.view.hideLoading()
            if case let .success(respon) = result {
                let json = JSON(respon.data)
                print(json)
                if json["type"] == "S" {
                    self?.pledgeModel = GLCompleteModel.GLPledgeModel.GLPledgeInfoModel.deserialize(from: json.rawString(), designatedPath: "results.pledge")
                    
                    if let pledgeModel = self?.pledgeModel {
                        self?.updateUI(pledgeModel: pledgeModel)
                    }
                }
            }
        })
    }
    
    /// 更新界面
    func updateUI(pledgeModel: GLCompleteModel.GLPledgeModel.GLPledgeInfoModel) -> Void {
        
        pledgeDate.text = pledgeModel.crea_date
        
        pictureArray.insert(contentsOf: pledgeModel.attachmentList, at: 0)
        collectionView.reloadData()
    }
    
    
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitAction(_ sender: UIBarButtonItem) {
        
        if pledgeDate.text == "请选择" {
            view.makeToast("请选择抵质押登记日期")
            return
        }
        
        let picArr = pictureArray.flatMap { (attModel) -> GLPauperInfoModel.GLAttachmentModel? in
            if attModel.attachment_href.isEmpty == true {
                return nil
            }
            return attModel
        }
        
        let listDic = picArr.toJSON() as! [[String: Any]]
        
        var backFlag = "0"
        if self.pledgeModel != nil {
            backFlag = "1"
        }
        
        let tabBarVc = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController as? GLTabBarController
        GLProvider.request(GLService.submitPledgeInfo(partyId: GLUser.partyId!, processExampleId: (model?.processId)!, processTaskId: (model?.processTaskId)!, backFlag: backFlag, crea_date: (pledgeDate.text)!, l_id: (model?.executionId)!, attachmentList: listDic)) { [weak self] (result) in
            
            if case let .success(respon) = result {
                let json = JSON(respon.data)
                print(json)
                if json["type"] == "S" {
                    tabBarVc?.showLoadingView(img: #imageLiteral(resourceName: "taskdetail_submit_success"), title: "提交成功")
                    NotificationCenter.default.post(name: YiRefreshNotificationName, object: nil)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                        tabBarVc?.dismissCover(btn: nil)
                        self?.navigationController?.dismiss(animated: false, completion: {
                            if let submitSuccess = self?.submitSuccess {
                                submitSuccess()
                            }
                        })
                    })
                } else {
                    tabBarVc?.showLoadingView(img: #imageLiteral(resourceName: "taskdetail_submit_failure"), title: "提交失败")
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                        tabBarVc?.dismissCover(btn: nil)
                        if json["code"] == "ERROR" {
                            self?.navigationController?.dismiss(animated: false, completion: {
                                if let submitSuccess = self?.submitSuccess {
                                    submitSuccess()
                                }
                            })
                        }
                    })
                }
            }
            
        }
    }
    
    
    @IBAction func pledgeAction(_ sender: UIButton) {
        GLDatePicker.showDatePicker(currentDate: Date()) { [weak self] (date) in
            self?.pledgeDate.text = date
        }
        view.endEditing(true)
    }
}


fileprivate let identifier = "GLTaskDetailPictureCell"
extension GLPledgeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let constant: CGFloat = CGFloat((Int(pictureArray.count-1)/3)+1) * 100.0 - 10
        collectionViewHeight.constant = constant
        return pictureArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let pictureCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? GLTaskDetailPictureCell else {
            return UICollectionViewCell()
        }
        if indexPath.row == pictureArray.count - 1 {
            pictureCell.deleteBtn.isHidden = true
            pictureCell.imageView.image = #imageLiteral(resourceName: "add_add_picture")
        } else {
            pictureCell.deleteBtn.isHidden = false
            let url = URL(string: pictureArray[indexPath.row].attachment_href)
            pictureCell.imageView.kf.setImage(with: url)
            
        }
        
        weak var weakCollectionView = collectionView
        pictureCell.deleteClosure = { [weak self] (cell)->() in
            self?.pictureArray.remove(at: indexPath.row)
            weakCollectionView?.reloadData()
        }
        return pictureCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == pictureArray.count - 1 { // 点击添加
            addPicture()
        }
    }
    
    func addPicture() {
        weak var weakSelf = self
        let alertController = UIAlertController(title: "选择图片方式", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "相机", style: .default, handler: { (action) in
            weakSelf?.choosePhoto(type: .camera)
        }))
        
        alertController.addAction(UIAlertAction(title: "相册", style: .default, handler: { (action) in
            weakSelf?.choosePhoto(type: .photoLibrary)
        }))
        alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    //选取相册
    func choosePhoto(type: UIImagePickerControllerSourceType) {
        //判断设置是否支持图片库
        if UIImagePickerController.isSourceTypeAvailable(type){
            let picker = UIImagePickerController()
            picker.delegate = self
            //指定图片控制器类型
            picker.sourceType = type
            self.present(picker, animated: true, completion: nil)
        }else{
            print("读取相册错误")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //获取选择的原图
        let pickedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imgData = UIImageJPEGRepresentation(pickedImage, 0.6)
        guard let imageData = imgData else { return }
        var multiParts = [MultipartFormData]()
        let multiPart = MultipartFormData(provider: .data(imageData), name: "file", fileName: "xxx.jpg", mimeType: "image/jpeg")
        multiParts.append(multiPart)
        let hud = JGProgressHUD(style: .dark)
        hud.indicatorView = JGProgressHUDPieIndicatorView()
        hud.show(in: self.view, animated: true)
        GLProvider.request(GLService.uploadFile(multiParts: multiParts), callbackQueue: DispatchQueue.main, progress: { (progressRespon) in
            print(progressRespon)
            hud.progress = Float(progressRespon.progress)
        }) { [weak self] (result) in
            if case let .success(respon) = result {
                print(JSON(respon.data))
                let jsonStr = JSON(respon.data)
                if jsonStr["type"] == "S" {
                    let picModel = GLPauperInfoModel.GLAttachmentModel(a_id: "", l_id: "", attachment_name: jsonStr["fileRealName"].stringValue, attachment_href: jsonStr["url"].stringValue, attachment_size: jsonStr["fileLength"].stringValue, attachment_filename: jsonStr["fileName"].stringValue, file_type: jsonStr["fileType"].stringValue)
                    self?.pictureArray.insert(picModel, at: (self?.pictureArray.count)! - 1)
                    self?.collectionView.reloadData()
                }
            }
            hud.dismiss()
        }
        
        //图片控制器退出
        picker.dismiss(animated: true, completion:nil)
    }
    
}


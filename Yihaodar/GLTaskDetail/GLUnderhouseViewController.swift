//
//  GLUnderhouseViewController.swift
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
import Kingfisher


/// 下户控制器
class GLUnderhouseViewController: UIViewController, UITextViewDelegate {
    
    /// 下户日期
    @IBOutlet weak var underDateLabel: UILabel!
    
    /// 下户地址是否相同
    @IBOutlet weak var underAdressSameLabel: UILabel!
    
    /// 下户来源
    @IBOutlet weak var underHouseSourceLabel: UILabel!
    
    /// 下户使用
    @IBOutlet weak var underHouseUseLabel: UILabel!
    
    /// 下户环境
    @IBOutlet weak var underHouseEnvironmentLabel: UILabel!
    
    @IBOutlet weak var underInHouseContrabandLabel: UILabel!
    
    @IBOutlet weak var underIdeaTextView: IQTextView!
    
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    
    
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
    
    var pauperModel: GLPauperInfoModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        checkBackGPSProcess()
    }
    
    /// 查询回退流程
    func checkBackGPSProcess() {
        view.showLoading()
        GLProvider.request(GLService.backPauperProcess(l_number: (model?.executionId)!), completion: { [weak self] (result) in
            self?.view.hideLoading()
            if case let .success(respon) = result {
                let json = JSON(respon.data)
                print(json)
                if json["type"] == "S" {
                    self?.pauperModel = GLPauperInfoModel.deserialize(from: json.rawString(), designatedPath: "results.pauper")
                    
                    if let pauperModel = self?.pauperModel {
                        self?.updateUI(pauperModel: pauperModel)
                    }
                } 
            }
        })
    }
    
    /// 更新界面
    func updateUI(pauperModel: GLPauperInfoModel) -> Void {
        
        underDateLabel.text = pauperModel.crea_date
        
        var r1 = GLRadioModel()
        r1.title = pauperModel.pauper_agreement
        selectedAdressSameModel = r1
        
        var r2 = GLRadioModel()
        r2.title = pauperModel.pauper_source
        selectedHouseSourceModel = r2
        
        var r3 = GLRadioModel()
        r3.title = pauperModel.pauper_purpose
        selectedHouseUseModel = r3
        
        var r4 = GLRadioModel()
        r4.title = pauperModel.pauper_environment
        selectedHouseEnvironmentModel = r4
        
        var r5 = GLRadioModel()
        r5.title = pauperModel.pauper_contraband
        selectedHouseContrabandModel = r5
        
        underIdeaTextView.text = pauperModel.pauper_opinion
        
        pictureArray.insert(contentsOf: pauperModel.attachmentList, at: 0)
        collectionView.reloadData()
    }
    
    
    
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitAction(_ sender: UIBarButtonItem) {
        
        view.endEditing(true)
        
        // 过滤判断
        if underDateLabel.text == "请选择" {
            view.makeToast("请选择下户日期")
            return
        }
        
        if selectedAdressSameModel == nil {
            view.makeToast("请选择下户申请地址是否一致")
            return
        }
        
        if selectedHouseSourceModel == nil {
            view.makeToast("请选择房屋居住来源")
            return
        }
        
        
        if selectedHouseUseModel == nil {
            view.makeToast("请选择房屋用途")
            return
        }
        
        if selectedHouseEnvironmentModel == nil {
            view.makeToast("请选择房屋周围环境")
            return
        }
        
        if selectedHouseContrabandModel == nil {
            view.makeToast("请选择房屋内有无违禁品")
            return
        }
        
        if underIdeaTextView.text.isEmpty == true {
            view.makeToast("请输入下户意见")
            return
        }
        
        // 提交下户
        
        let picArr = pictureArray.flatMap { (attModel) -> GLPauperInfoModel.GLAttachmentModel? in
            if attModel.attachment_href.isEmpty == true {
                return nil
            }
            return attModel
        }
        
        let listDic = picArr.toJSON() as! [[String: Any]]
        
        
        var fallbackf = "0"
        if self.pauperModel != nil {
            fallbackf = "1"
        }
        
        
        let tabBarVc = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController as? GLTabBarController
        GLProvider.request(GLService.submitPauperInfo(partyId: GLUser.partyId!, processId: (model?.processId)!, processTaskId: (model?.processTaskId)!, fallbackf: fallbackf, crea_date: (underDateLabel.text)!, pauper_agreement: (selectedAdressSameModel?.title)!, pauper_source: (selectedHouseSourceModel?.title)!, pauper_contraband: (selectedHouseContrabandModel?.title)!, pauper_environment: (selectedHouseEnvironmentModel?.title)!, pauper_purpose: (selectedHouseUseModel?.title)!, pauper_opinion: underIdeaTextView.text, l_number: (model?.executionId)!, p_id: "", fileInfo: listDic)) { [weak self] (result) in
            
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
    
    
    
    @IBAction func underDateAction(_ sender: UIButton) {
        GLDatePicker.showDatePicker(currentDate: Date()) { [weak self] (date) in
            self?.underDateLabel.text = date
        }
        view.endEditing(true)
    }
    
    var selectedAdressSameModel: GLRadioModel?
    @IBAction func underAdressSameAction(_ sender: UIButton) {
        // 加载数据
        let path = Bundle.main.path(forResource: "shifouyizhi", ofType: "plist")
        guard let filePath = path else { return }
        let arr = NSArray(contentsOfFile: filePath) as? [Any]
        // 字典数组 转模型数组
        guard var dataArray = [GLRadioModel].deserialize(from: arr) as? [GLRadioModel] else { return }
        if let selectedAdressSameModel = selectedAdressSameModel {
            dataArray = dataArray.map({ (radioModel) -> GLRadioModel in
                var radioModel = radioModel
                if selectedAdressSameModel.id == radioModel.id {
                    radioModel = selectedAdressSameModel
                }
                return radioModel
            })
        }
        
        let radioVc = GLRadioViewController.jumpRadioVc(title: "选择下户与申请地址是否一致", dataArray: dataArray, navigationVc: navigationController)
        radioVc.searchBarIsHidden = true
        radioVc.closeClosure = { [weak self] (radioModel) in
            self?.selectedAdressSameModel = radioModel
            self?.underAdressSameLabel.text = radioModel.title
        }
    }
    
    var selectedHouseSourceModel: GLRadioModel?
    @IBAction func underHouseSourceAction(_ sender: UIButton) {
        // 加载数据
        let path = Bundle.main.path(forResource: "fangwulaiyuan", ofType: "plist")
        guard let filePath = path else { return }
        let arr = NSArray(contentsOfFile: filePath) as? [Any]
        // 字典数组 转模型数组
        guard var dataArray = [GLRadioModel].deserialize(from: arr) as? [GLRadioModel] else { return }
        if let selectedHouseSourceModel = selectedHouseSourceModel {
            dataArray = dataArray.map({ (radioModel) -> GLRadioModel in
                var radioModel = radioModel
                if selectedHouseSourceModel.id == radioModel.id {
                    radioModel = selectedHouseSourceModel
                }
                return radioModel
            })
        }
        
        let radioVc = GLRadioViewController.jumpRadioVc(title: "选择房屋居住来源", dataArray: dataArray, navigationVc: navigationController)
        radioVc.searchBarIsHidden = true
        radioVc.closeClosure = { [weak self] (radioModel) in
            self?.selectedHouseSourceModel = radioModel
            self?.underHouseSourceLabel.text = radioModel.title
        }
    }
    
    var selectedHouseUseModel: GLRadioModel?
    @IBAction func underHouseUseAction(_ sender: UIButton) {
        // 加载数据
        let path = Bundle.main.path(forResource: "fangwuyongtu", ofType: "plist")
        guard let filePath = path else { return }
        let arr = NSArray(contentsOfFile: filePath) as? [Any]
        // 字典数组 转模型数组
        guard var dataArray = [GLRadioModel].deserialize(from: arr) as? [GLRadioModel] else { return }
        if let selectedHouseUseModel = selectedHouseUseModel {
            dataArray = dataArray.map({ (radioModel) -> GLRadioModel in
                var radioModel = radioModel
                if selectedHouseUseModel.id == radioModel.id {
                    radioModel = selectedHouseUseModel
                }
                return radioModel
            })
        }
        
        let radioVc = GLRadioViewController.jumpRadioVc(title: "选择房屋用途", dataArray: dataArray, navigationVc: navigationController)
        radioVc.searchBarIsHidden = true
        radioVc.closeClosure = { [weak self] (radioModel) in
            self?.selectedHouseUseModel = radioModel
            self?.underHouseUseLabel.text = radioModel.title
        }
    }
    
    var selectedHouseEnvironmentModel: GLRadioModel?
    @IBAction func underHouseEnvironmentAction(_ sender: UIButton) {
        // 加载数据
        let path = Bundle.main.path(forResource: "fangwuhuanjing", ofType: "plist")
        guard let filePath = path else { return }
        let arr = NSArray(contentsOfFile: filePath) as? [Any]
        // 字典数组 转模型数组
        guard var dataArray = [GLRadioModel].deserialize(from: arr) as? [GLRadioModel] else { return }
        if let selectedHouseEnvironmentModel = selectedHouseEnvironmentModel {
            dataArray = dataArray.map({ (radioModel) -> GLRadioModel in
                var radioModel = radioModel
                if selectedHouseEnvironmentModel.id == radioModel.id {
                    radioModel = selectedHouseEnvironmentModel
                }
                return radioModel
            })
        }
        
        let radioVc = GLRadioViewController.jumpRadioVc(title: "选择房屋周围环境", dataArray: dataArray, navigationVc: navigationController)
        radioVc.searchBarIsHidden = true
        radioVc.closeClosure = { [weak self] (radioModel) in
            self?.selectedHouseEnvironmentModel = radioModel
            self?.underHouseEnvironmentLabel.text = radioModel.title
        }
    }
    
    var selectedHouseContrabandModel: GLRadioModel?
    @IBAction func underInHouseContrabandAction(_ sender: UIButton) {
        // 加载数据
        let path = Bundle.main.path(forResource: "youwu", ofType: "plist")
        guard let filePath = path else { return }
        let arr = NSArray(contentsOfFile: filePath) as? [Any]
        // 字典数组 转模型数组
        guard var dataArray = [GLRadioModel].deserialize(from: arr) as? [GLRadioModel] else { return }
        if let selectedHouseContrabandModel = selectedHouseContrabandModel {
            dataArray = dataArray.map({ (radioModel) -> GLRadioModel in
                var radioModel = radioModel
                if selectedHouseContrabandModel.id == radioModel.id {
                    radioModel = selectedHouseContrabandModel
                }
                return radioModel
            })
        }
        
        let radioVc = GLRadioViewController.jumpRadioVc(title: "选择房屋内有无违禁品", dataArray: dataArray, navigationVc: navigationController)
        radioVc.searchBarIsHidden = true
        radioVc.closeClosure = { [weak self] (radioModel) in
            self?.selectedHouseContrabandModel = radioModel
            self?.underInHouseContrabandLabel.text = radioModel.title
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textViewHeight.constant = textView.contentSize.height   
    }
}

fileprivate let identifier = "GLTaskDetailPictureCell"
extension GLUnderhouseViewController: UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
    
    
    /// 添加图片
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
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newString = (textView.text! as NSString).replacingCharacters(in: range, with: text)
        print(newString)
        let expression = "^.{0,50}$"
        let regex = try! NSRegularExpression(pattern: expression, options: NSRegularExpression.Options.allowCommentsAndWhitespace)
        let numberOfMatches = regex.numberOfMatches(in: newString, options:NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, (newString as NSString).length))
        
        return numberOfMatches != 0
    }
    
}

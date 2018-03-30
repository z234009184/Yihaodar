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



/// 下户控制器
class GLUnderhouseViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var underDateLabel: UILabel!
    
    @IBOutlet weak var underAdressSameLabel: UILabel!
    
    @IBOutlet weak var underHouseSourceLabel: UILabel!
    
    @IBOutlet weak var underHouseUseLabel: UILabel!
    
    @IBOutlet weak var underHouseEnvironmentLabel: UILabel!
    
    @IBOutlet weak var underInHouseContrabandLabel: UILabel!
    
    @IBOutlet weak var underIdeaTextView: IQTextView!
    
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    private lazy var pictureArray: [GLCcroModel] = {
        var arr: [GLCcroModel] = []
        let ccroModel = GLCcroModel()
        arr.append(ccroModel)
        return arr
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitAction(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func underDateAction(_ sender: UIButton) {
    }
    @IBAction func underAdressSameAction(_ sender: UIButton) {
    }
    @IBAction func underHouseSourceAction(_ sender: UIButton) {
    }
    @IBAction func underHouseUseAction(_ sender: UIButton) {
    }
    @IBAction func underHouseEnvironmentAction(_ sender: UIButton) {
    }
    @IBAction func underInHouseContrabandAction(_ sender: UIButton) {
    }
    @IBAction func underIdeaAction(_ sender: UIButton) {
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
            pictureCell.imageView.image = pictureArray[indexPath.row].image
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
                    let ccroModel = GLCcroModel(fileTypeName: "0", fileName: jsonStr["fileName"].stringValue, fileUrl: jsonStr["url"].stringValue, fileSize: jsonStr["fileLength"].stringValue, image: pickedImage)
                    self?.pictureArray.insert(ccroModel, at: (self?.pictureArray.count)! - 1)
                    self?.collectionView.reloadData()
                }
            }
            hud.dismiss()
        }
        
        //图片控制器退出
        picker.dismiss(animated: true, completion:nil)
    }
    
}

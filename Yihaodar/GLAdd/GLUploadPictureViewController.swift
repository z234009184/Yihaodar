//
//  GLUploadPictureViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/26.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring
import HandyJSON
import SwiftyJSON
import Moya
import JGProgressHUD

struct GLCcroModel: HandyJSON {
    var fileTypeName = ""
    var fileName = ""
    var fileUrl = ""
    var fileSize = ""
    var image = UIImage()
}


class GLUploadPictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var firstCollectionView: UICollectionView!
    @IBOutlet weak var firstCollectionViewHeight: NSLayoutConstraint!
    private lazy var firstDataArray: [GLCcroModel] = {
        var arr: [GLCcroModel] = []
        let ccroModel = GLCcroModel()
        arr.append(ccroModel)
        return arr
    }() 
    
    
    @IBOutlet weak var secondCollectionView: UICollectionView!
    @IBOutlet weak var secondCollectionViewHeight: NSLayoutConstraint!
    private lazy var secondDataArray: [GLCcroModel] = {
        var arr: [GLCcroModel] = []
        let ccroModel = GLCcroModel()
        arr.append(ccroModel)
        return arr
    }()
    
    
    @IBOutlet weak var thirdCollectionView: UICollectionView!
    @IBOutlet weak var thirdCollectionViewHeight: NSLayoutConstraint!
    private lazy var thirdDataArray: [GLCcroModel] = {
        var arr: [GLCcroModel] = []
        let ccroModel = GLCcroModel()
        arr.append(ccroModel)
        return arr
    }()
    
    
    @IBOutlet weak var fourCollectionView: UICollectionView!
    @IBOutlet weak var fourCollectionViewHeight: NSLayoutConstraint!
    private lazy var fourDataArray: [GLCcroModel] = {
        var arr: [GLCcroModel] = []
        let ccroModel = GLCcroModel()
        arr.append(ccroModel)
        return arr
    }()
    
    @IBOutlet weak var fiveCollectionView: UICollectionView!
    @IBOutlet weak var fiveCollectionViewHeight: NSLayoutConstraint!
    private lazy var fiveDataArray: [GLCcroModel] = {
        var arr: [GLCcroModel] = []
        let ccroModel = GLCcroModel()
        arr.append(ccroModel)
        return arr
    }()
    
    
    
    private var selectedCollectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backItem = UIBarButtonItem()
        backItem.title = "上一步";
        navigationItem.backBarButtonItem = backItem;
        navigationItem.title = "新建车辆评估"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一步", style: .done, target: self, action: #selector(GLUploadPictureViewController.nextBtnClick(item:)))
        
    }
    
    @objc func nextBtnClick(item: UIBarButtonItem) {
        firstDataArray.removeLast()
        secondDataArray.removeLast()
        thirdDataArray.removeLast()
        fourDataArray.removeLast()
        fiveDataArray.removeLast()
        
        let ccroList = firstDataArray + secondDataArray + thirdDataArray + fourDataArray + fiveDataArray
        
        GLEstimateResultViewController.summitModel.ccroList = ccroList
        
        
        
        let vc = UIStoryboard(name: "GLCreateCarEstimate", bundle: Bundle(for: type(of: self))).instantiateViewController(withIdentifier: "GLEstimateResultViewController") as! GLEstimateResultViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}




fileprivate let identifier = "GLTaskDetailPictureCell"
extension GLUploadPictureViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        switch collectionView {
        case firstCollectionView:
            let constant: CGFloat = CGFloat((Int(firstDataArray.count-1)/3)+1) * 100.0 - 10
            firstCollectionViewHeight.constant = constant
            return firstDataArray.count
        case secondCollectionView:
            let constant: CGFloat = CGFloat((Int(secondDataArray.count-1)/3)+1) * 100.0 - 10
            secondCollectionViewHeight.constant = constant
            return secondDataArray.count
        case thirdCollectionView:
            let constant: CGFloat = CGFloat((Int(thirdDataArray.count-1)/3)+1) * 100.0 - 10
            thirdCollectionViewHeight.constant = constant
            return thirdDataArray.count
        case fourCollectionView:
            let constant: CGFloat = CGFloat((Int(fourDataArray.count-1)/3)+1) * 100.0 - 10
            fourCollectionViewHeight.constant = constant
             return fourDataArray.count
        case fiveCollectionView:
            let constant: CGFloat = CGFloat((Int(fiveDataArray.count-1)/3)+1) * 100.0 - 10
            fiveCollectionViewHeight.constant = constant
            return fiveDataArray.count
        default:
            return 0
        }
        
    }
    
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let pictureCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? GLTaskDetailPictureCell else {
            return UICollectionViewCell()
        }
        
        
        switch collectionView {
        case firstCollectionView:
            if indexPath.row == firstDataArray.count - 1 {
                pictureCell.deleteBtn.isHidden = true
                pictureCell.imageView.image = #imageLiteral(resourceName: "add_add_picture")
            } else {
                pictureCell.deleteBtn.isHidden = false
                pictureCell.imageView.image = firstDataArray[indexPath.row].image
            }
            break
        case secondCollectionView:
            if indexPath.row == secondDataArray.count - 1 {
                pictureCell.deleteBtn.isHidden = true
                pictureCell.imageView.image = #imageLiteral(resourceName: "add_add_picture")
            } else {
                pictureCell.deleteBtn.isHidden = false
                pictureCell.imageView.image = secondDataArray[indexPath.row].image
            }
            
            break
        case thirdCollectionView:
            if indexPath.row == thirdDataArray.count - 1 {
                pictureCell.deleteBtn.isHidden = true
                pictureCell.imageView.image = #imageLiteral(resourceName: "add_add_picture")
            } else {
                pictureCell.deleteBtn.isHidden = false
                pictureCell.imageView.image = thirdDataArray[indexPath.row].image
            }
            
            break
        case fourCollectionView:
            if indexPath.row == fourDataArray.count - 1 {
                pictureCell.deleteBtn.isHidden = true
                pictureCell.imageView.image = #imageLiteral(resourceName: "add_add_picture")
            } else {
                pictureCell.deleteBtn.isHidden = false
                pictureCell.imageView.image = fourDataArray[indexPath.row].image
            }
            break
        case fiveCollectionView:
            if indexPath.row == fiveDataArray.count - 1 {
                pictureCell.deleteBtn.isHidden = true
                pictureCell.imageView.image = #imageLiteral(resourceName: "add_add_picture")
            } else {
                pictureCell.deleteBtn.isHidden = false
                pictureCell.imageView.image = fiveDataArray[indexPath.row].image
            }
            break
        default:
            break
        }
        
        
        
        weak var weakCollectionView = collectionView
        pictureCell.deleteClosure = { [weak self] (cell)->() in
            switch weakCollectionView! {
            case (self?.firstCollectionView)!:
                self?.firstDataArray.remove(at: indexPath.row)
                break
            case (self?.secondCollectionView)!:
                self?.secondDataArray.remove(at: indexPath.row)
                break
            case (self?.thirdCollectionView)!:
                self?.thirdDataArray.remove(at: indexPath.row)
                break
            case (self?.fourCollectionView)!:
                self?.fourDataArray.remove(at: indexPath.row)
                break
            case (self?.fiveCollectionView)!:
                self?.fiveDataArray.remove(at: indexPath.row)
                break
            default:
                break
            }
            
            weakCollectionView?.reloadData()
        }
        
        return pictureCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        switch collectionView {
        case firstCollectionView:
            if indexPath.row == firstDataArray.count - 1 { // 点击添加
                selectedCollectionView = collectionView
                addPicture()
            }
            break
        case secondCollectionView:
            if indexPath.row == secondDataArray.count - 1 { // 点击添加
                selectedCollectionView = collectionView
                addPicture()
            }
            break
        case thirdCollectionView:
            if indexPath.row == thirdDataArray.count - 1 { // 点击添加
                selectedCollectionView = collectionView
                addPicture()
            }
            break
        case fourCollectionView:
            if indexPath.row == fourDataArray.count - 1 { // 点击添加
                selectedCollectionView = collectionView
                addPicture()
            }
            break
        case fiveCollectionView:
            if indexPath.row == fiveDataArray.count - 1 { // 点击添加
                selectedCollectionView = collectionView
                addPicture()
            }
            break
        default:
            break
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
                    var ccroModel = GLCcroModel(fileTypeName: "0", fileName: jsonStr["fileName"].rawString()!, fileUrl: jsonStr["url"].rawString()!, fileSize: String((imageData as NSData).length), image: pickedImage)
                    
                    guard let selectedView = self?.selectedCollectionView else { return }
                    switch selectedView {
                    case (self?.firstCollectionView)!:
                        ccroModel.fileTypeName = "0"
                        self?.firstDataArray.insert(ccroModel, at: (self?.firstDataArray.count)! - 1)
                        self?.firstCollectionView.reloadData()
                        break
                    case (self?.secondCollectionView)!:
                        ccroModel.fileTypeName = "1"
                        self?.secondDataArray.insert(ccroModel, at: (self?.secondDataArray.count)! - 1)
                        self?.secondCollectionView.reloadData()
                        break
                    case (self?.thirdCollectionView)!:
                        ccroModel.fileTypeName = "2"
                        self?.thirdDataArray.insert(ccroModel, at: (self?.thirdDataArray.count)! - 1)
                        self?.thirdCollectionView.reloadData()
                        break
                    case (self?.fourCollectionView)!:
                        ccroModel.fileTypeName = "3"
                        self?.fourDataArray.insert(ccroModel, at: (self?.fourDataArray.count)! - 1)
                        self?.fourCollectionView.reloadData()
                        break
                    case (self?.fiveCollectionView)!:
                        ccroModel.fileTypeName = "4"
                        self?.fiveDataArray.insert(ccroModel, at: (self?.fiveDataArray.count)! - 1)
                        self?.fiveCollectionView.reloadData()
                        break
                    default:
                        break
                    }
                    
                }
            }
            hud.dismiss()
        }
            
        
        //图片控制器退出
        picker.dismiss(animated: true, completion:nil)
    }
    
    
}

//
//  GLTaskDetailPictureViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/9.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring
import SKPhotoBrowser
import IQKeyboardManagerSwift


class GLTaskDetailPictureViewController: GLTaskDetailBaseViewController {
    /// 报单信息 --------------------
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var orderPersonLabel: UILabel!
    @IBOutlet weak var orderSubmitDateLabel: UILabel!

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    
    /// 评估信息 ---------------------
    @IBOutlet weak var estimateMsgView: DesignableView!
    
    @IBOutlet weak var estimateMsgViewTop: NSLayoutConstraint!
    
    @IBOutlet weak var estimateDateLabel: UILabel!
    @IBOutlet weak var estimatePriceLabel: UILabel!
    @IBOutlet weak var estimateCarDetailMsgLabel: UILabel!
    @IBOutlet weak var estimateMemoLabel: UILabel!
    
    /// 失效视图 ---------------------
    @IBOutlet weak var invalidView: UIView!
    @IBOutlet weak var invalidDateLabel: UILabel!
    
    
    
    /// 底部评估视图 ---------------------
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var estimateButton: DesignableButton!
    
    @IBOutlet weak var bottomViewBottom: NSLayoutConstraint!
    

    
    
    var imgnames = ["avatar","avatar","avatar","avatar","avatar",]
    var imagesss = [SKPhoto]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "任务详情"
        let photo = SKPhoto.photoWithImage(#imageLiteral(resourceName: "avatar"))
        imagesss.append(photo)
        imagesss.append(photo)
        imagesss.append(photo)
        imagesss.append(photo)
        imagesss.append(photo)
        
        
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
    }
    
    
    /// 提交评估
    @IBAction func estimateBtnClick(_ sender: DesignableButton) {
        showSubmitMessageView()
    }
    
}


class GLTaskDetailPictureCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

fileprivate let identifier = "GLTaskDetailPictureCell"
extension GLTaskDetailPictureViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgnames.count
    }
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        guard let pictureCell = cell as? GLTaskDetailPictureCell else {
            return UICollectionViewCell()
        }
        pictureCell.imageView.image = UIImage(named: imgnames[indexPath.item])
        
        return pictureCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? GLTaskDetailPictureCell else { return }
        
        let originImage = cell.imageView.image // some image for baseImage
        
        let browser = SKPhotoBrowser(originImage: originImage ?? UIImage(), photos: imagesss, animatedFromView: cell)
        browser.initializePageIndex(indexPath.item)
        present(browser, animated: true, completion: nil)
        
    }
}


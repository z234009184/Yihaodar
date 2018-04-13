//
//  ContentViewCell.swift
//  SheetViewSwift
//
//  Created by mengminduan on 2017/9/29.
//  Copyright © 2017年 mengminduan. All rights reserved.
//

import UIKit

class GLCollectionFormItemCell: UICollectionViewCell {
    
    var label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        
        backgroundColor = .white
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        
        layer.borderColor = UIColor(red: 0xed / 255.0, green: 0xee / 255.0, blue: 0xf1 / 255.0, alpha: 1.0).cgColor
        layer.borderWidth = 0.5
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class ContentViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    

    var cellCollectionView: UICollectionView?
    
    var cellForItemAtIndexPathClosure: ((NSIndexPath) -> String)?
    var numberOfItemsInSectionClosure: ((Int) -> Int)?
    var sizeForItemAtIndexPathClosure: ((UICollectionViewLayout?, NSIndexPath) -> CGSize)?
    var ContentViewCellDidScrollClosure: ((UIScrollView) ->Void)?
    var cellWithColorAtIndexPathClosure: ((NSIndexPath) -> Bool)?
    var cellDidSelectedClosure: ((NSIndexPath) -> Void)?

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        let rect = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        self.cellCollectionView = UICollectionView(frame: rect, collectionViewLayout: layout)
        self.cellCollectionView?.showsHorizontalScrollIndicator = false
        self.cellCollectionView?.backgroundColor = .white
        self.cellCollectionView?.register(GLCollectionFormItemCell.self, forCellWithReuseIdentifier: "inner.cell")
        self.cellCollectionView?.dataSource = self
        self.cellCollectionView?.delegate = self
        self.cellCollectionView?.bounces = false
        
        self.contentView.addSubview(self.cellCollectionView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.ContentViewCellDidScrollClosure != nil {
            self.ContentViewCellDidScrollClosure!(scrollView)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numberOfItemsInSectionClosure!(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.sizeForItemAtIndexPathClosure!(collectionViewLayout, indexPath as NSIndexPath)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "inner.cell", for: indexPath) as? GLCollectionFormItemCell else { return GLCollectionFormItemCell() }
//        var hasColor = false
//        if self.cellWithColorAtIndexPathClosure != nil {
//            hasColor = self.cellWithColorAtIndexPathClosure!(indexPath as NSIndexPath)
//        }
        
        cell.label.frame.width = self.sizeForItemAtIndexPathClosure!(nil, indexPath as NSIndexPath).width
        cell.label.frame.height = self.sizeForItemAtIndexPathClosure!(nil, indexPath as NSIndexPath).height
        cell.label.text = self.cellForItemAtIndexPathClosure!(indexPath as NSIndexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.cellDidSelectedClosure != nil {
            self.cellDidSelectedClosure!(indexPath as NSIndexPath)
        }
    }
}

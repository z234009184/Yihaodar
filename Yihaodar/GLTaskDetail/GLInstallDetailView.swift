//
//  GLInstallDetailView.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/3/28.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring
import IQKeyboardManagerSwift

class GLInstallDetailView: UIView, UITextViewDelegate {
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBOutlet weak var deviceTypeLabel: UILabel!
    
    @IBOutlet weak var deviceVersionLabel: UILabel!
    
    @IBOutlet weak var deviceNumberLabel: UILabel!
    
    @IBOutlet weak var deviceSIMNumberLabel: UILabel!
    
    @IBOutlet weak var installLocationLabel: UILabel!
    
    @IBOutlet weak var remarksTextView: IQTextView!
    
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    
    
    var deleteClosure: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let str1 = NSMutableAttributedString(string: "删除")
        let range1 = NSRange(location: 0, length: str1.length)
        let number = NSNumber(value:NSUnderlineStyle.styleSingle.rawValue)//此处需要转换为NSNumber 不然不对,rawValue转换为integer
        str1.addAttribute(NSAttributedStringKey.underlineStyle, value: number, range: range1)
        str1.addAttribute(NSAttributedStringKey.foregroundColor, value: YiBlueColor, range: range1)
        deleteBtn.setAttributedTitle(str1, for: .normal)
    }
    
    @IBAction func deviceTypeAction(_ sender: UIButton) {
    }
    
    @IBAction func deviceVersionAction(_ sender: UIButton) {
    }
    
    @IBAction func deviceNumberAction(_ sender: UIButton) {
    }
    
    @IBAction func deviceSIMNumberAction(_ sender: UIButton) {
    }
    
    @IBAction func installLocationAction(_ sender: UIButton) {
    }
    
    @IBAction func deleteAction(_ sender: UIButton) {
        guard let deleteClosure = deleteClosure else {
            return
        }
        deleteClosure()
    }
    
    
    
    func textViewDidChange(_ textView: UITextView) {
        textViewHeight.constant = textView.contentSize.height
    }
    
}


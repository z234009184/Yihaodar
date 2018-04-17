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
    
    @IBOutlet weak var deviceVersionTextView: IQTextView!
    
    @IBOutlet weak var deviceNumberTextView: IQTextView!
    
    @IBOutlet weak var deviceSIMNumberTextView: IQTextView!
    
    @IBOutlet weak var installLocationTextView: IQTextView!
    
    @IBOutlet weak var remarksTextView: IQTextView!
    
    
    
    @IBOutlet weak var versionHeight: NSLayoutConstraint!
    
    @IBOutlet weak var numberHeight: NSLayoutConstraint!
    
    @IBOutlet weak var simCardHeight: NSLayoutConstraint!
    
    @IBOutlet weak var installLocationHeight: NSLayoutConstraint!
    
    @IBOutlet weak var remarksHeight: NSLayoutConstraint!
    
    
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
    
    
    
    @IBAction func deleteAction(_ sender: UIButton) {
        guard let deleteClosure = deleteClosure else {
            return
        }
        deleteClosure()
    }
    
    
    
    func textViewDidChange(_ textView: UITextView) {
        switch textView {
        case deviceVersionTextView:
            versionHeight.constant = textView.contentSize.height
        case deviceNumberTextView:
            numberHeight.constant = textView.contentSize.height
        case deviceSIMNumberTextView:
            simCardHeight.constant = textView.contentSize.height
        case installLocationTextView:
            installLocationHeight.constant = textView.contentSize.height
        case remarksTextView:
            remarksHeight.constant = textView.contentSize.height
        default:
            break
        }
        
    }
    
}


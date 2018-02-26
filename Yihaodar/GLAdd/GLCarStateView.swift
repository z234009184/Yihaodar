//
//  GLCarStateView.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/26.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring

class GLCarStateView: UIView, UITextViewDelegate {
    
    var deleteClosure: (()->())?
    
    @IBOutlet weak var deleteBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        let str1 = NSMutableAttributedString(string: "删除")
        let range1 = NSRange(location: 0, length: str1.length)
        let number = NSNumber(value:NSUnderlineStyle.styleSingle.rawValue)//此处需要转换为NSNumber 不然不对,rawValue转换为integer
        str1.addAttribute(NSAttributedStringKey.underlineStyle, value: number, range: range1)
        str1.addAttribute(NSAttributedStringKey.foregroundColor, value: YiBlueColor, range: range1)
        deleteBtn.setAttributedTitle(str1, for: .normal)
        
    }
    
    @IBAction func deleteBtnClick(_ sender: UIButton) {
        guard let deleteClosure = deleteClosure else {
            return
        }
        deleteClosure()
        
    }
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    
    func textViewDidChange(_ textView: UITextView) {
        textViewHeight.constant = textView.contentSize.height
    }
    
}

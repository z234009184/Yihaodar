//
//  GLSubmitMessageView.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/10.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring

class GLSubmitMessageView: UIView {
    
    @IBOutlet var view: UIView!
    
    @IBOutlet weak var priceTextField: DesignableTextField!
    
    @IBOutlet weak var carMsgTextField: DesignableTextField!
    
    @IBOutlet weak var memoTextField: DesignableTextField!
    
    var submitBtnClosure: (()->())?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViewFromNib()
    }
    
    private func initViewFromNib(){
        self.backgroundColor = .clear
        // 需要这句代码，不能直接写UINib(nibName: "MyView", bundle: nil)，不然不能在storyboard中显示
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "GLSubmitMessageView", bundle: bundle)
        self.view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        self.view.frame = bounds
        self.addSubview(view)
    }
    
    
    @IBAction func submitBtnClick(_ sender: UIButton) {
        guard let submitBtnClosure = submitBtnClosure else {
            return
        }
        submitBtnClosure()
    }
    
    @IBAction func priceTextFieldChanged(_ textField: DesignableTextField) {
        
    }
    
}

extension GLSubmitMessageView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        
        
        if textField == priceTextField {
            let expression = "^[0-9]{0,20}((\\.)[0-9]{0,2})?$"
            let regex = try! NSRegularExpression(pattern: expression, options: NSRegularExpression.Options.allowCommentsAndWhitespace)
            let numberOfMatches = regex.numberOfMatches(in: newString, options:NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, (newString as NSString).length))
            
            if newString.count > 20 {
                return false
            }
            
            return numberOfMatches != 0
        }
        
        if textField == carMsgTextField {
            if newString.count > 20 {
                return false
            }
        }
        
        if textField == memoTextField {
            if newString.count > 500 {
                return false
            }
        }
        
        return true
        
    }
    
    
}


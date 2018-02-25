//
//  GLSubmitMessagePriceView.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/25.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring

class GLSubmitMessagePriceView: SpringView {
    @IBOutlet weak var priceTextField: DesignableTextField!
    
    var submitBtnClosure: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func submitBtnClick(_ sender: UIButton) {
        guard let submitBtnClosure = submitBtnClosure else {
            return
        }
        submitBtnClosure()
        
    }
}

extension GLSubmitMessagePriceView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        print(textField.text as Any, string)
        if textField != priceTextField {
            return true
        }
        
        
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        print(newString)
        let expression = "^[0-9]{0,20}((\\.)[0-9]{0,2})?$"
        let regex = try! NSRegularExpression(pattern: expression, options: NSRegularExpression.Options.allowCommentsAndWhitespace)
        let numberOfMatches = regex.numberOfMatches(in: newString, options:NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, (newString as NSString).length))
        
        return numberOfMatches != 0
        
    }
    
    
}

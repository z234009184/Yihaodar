//
//  CustomUI.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/3/22.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring

class GLPlaceHolderLabel: SpringLabel {
    
    override var text: String? {
        didSet{
            print(oldValue)
            
            if oldValue?.isEmpty == true {
                textColor = YiUnselectedTitleColor
                text = "未填写"
            } else {
                textColor = YiSelectedTitleColor
            }
        }
    }
}

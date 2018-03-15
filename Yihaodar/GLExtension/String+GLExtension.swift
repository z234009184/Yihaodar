//
//  String+GLExtension.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/28.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Foundation

extension String {
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize()
        
        return String(format: hash as String)
    }
    
    func decimalString() -> String {
        
        let price = Double(self)
        
        guard let priceNum = price else { return self}
        
        let format = NumberFormatter()
        //设置numberStyle（有多种格式）
        format.numberStyle = .decimal
        //转换后的string
        let string = format.string(from: NSNumber(value: priceNum))
        
        return string ?? self
    }
}


//
//  GLDatePicker.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/27.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring

class GLDatePicker: NSObject {
    static let tabBarVc = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController as! GLTabBarController
    static var sureClosure: ((String)->())?
    static var date = Date()
    static var pickerView = SpringView()
    
    
    static func showDatePicker(currentDate: Date, sureClosure: @escaping ((String)->())) {
        let mask = tabBarVc.showMaskView()
        guard let maskView = mask else {
            assert(mask != nil, "没有mask")
            return
        }
        date = currentDate
        self.sureClosure = sureClosure
        
        pickerView = SpringView(frame: CGRect(x:0, y:maskView.frame.size.height - 260, width:maskView.frame.width, height:216))
        pickerView.animation = "slideUp"
        pickerView.duration = 0.5
        pickerView.animate()
        let toolBarView = UIToolbar(frame: CGRect(x:0, y:0, width:pickerView.frame.width, height:44))
        let cancelItem = UIBarButtonItem(title: "取消", style: .done, target: self, action: #selector(cancelAction))
        cancelItem.width = 80
        cancelItem.tintColor = YiSelectedTitleColor
        let springItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let sureItem = UIBarButtonItem(title: "确定", style: .done, target: self, action: #selector(sureAction))
        sureItem.width = 80
        sureItem.tintColor = YiSelectedTitleColor
        toolBarView.items = [cancelItem, springItem, sureItem]
        
        pickerView.addSubview(toolBarView)
        maskView.addSubview(pickerView)
        
        //创建日期选择器
        let datePicker = UIDatePicker(frame: CGRect(x:0, y:44, width:maskView.frame.width, height:216))
        datePicker.backgroundColor = .white
        datePicker.setDate(currentDate, animated: true)
        //将日期选择器区域设置为中文，则选择器日期显示为中文
        datePicker.locale = Locale(identifier: "zh_CN")
        datePicker.datePickerMode = .date
        //注意：action里面的方法名后面需要加个冒号“：”
        datePicker.addTarget(self, action: #selector(dateChanged(datePicker:)),
                             for: .valueChanged)
        pickerView.addSubview(datePicker)
        
    }
    
    
    @objc static func cancelAction() {
        pickerView.animation = "fall"
        pickerView.duration = 0.5
        pickerView.animate()
        tabBarVc.dismissCover(btn: nil)
    }
    @objc static func sureAction() {
        guard let sure = sureClosure else { return }
        let dateStr = stringFromDate(date: date as NSDate, format: "yyyy-MM-dd")
        sure(dateStr)
        pickerView.animation = "fall"
        pickerView.duration = 0.5
        pickerView.animate()
        tabBarVc.dismissCover(btn: nil)
    }
    
    //日期选择器响应方法
    @objc static func dateChanged(datePicker : UIDatePicker){
        date = datePicker.date
//        //更新提醒时间文本框
//        let formatter = DateFormatter()
//        //日期样式
//        formatter.dateFormat = "yyyy年MM月dd日"
//        print(formatter.string(from: datePicker.date))
    }
    
}

//
//  GLService.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/28.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Moya
import SwiftyJSON
import Result

struct CustomPlugin: PluginType {
    
    
    static let requestTimeoutClosure = { (endpoint: Endpoint<GLService>, done: @escaping MoyaProvider<GLService>.RequestResultClosure) in
        guard var request = try? endpoint.urlRequest() else { return }
        request.timeoutInterval = 10    //设置请求超时时间
        done(.success(request))
    }
    
    
    
    let tokenClosure: () -> String?
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        //获取获取令牌字符串
        if let token = tokenClosure() {
            //将token添加到请求头中
            request.addValue(token, forHTTPHeaderField: "token")
            request.addValue("iOS", forHTTPHeaderField: "channel")
//            request.addValue(, forHTTPHeaderField: <#T##String#>)
            
        }
        return request
    }
    
    func willSend(_ request: RequestType, target: TargetType) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        guard let window = UIApplication.shared.keyWindow else { return }
        
        if case let Result.success(response) = result {
            let json = JSON(response.data)
            if json["type"] == "E" {
                let msg = json["message"].stringValue
                window.makeToast(msg)
                if json["code"] == "TOKEN IS ERROR" || json["code"] == "TOKEN IS OVER TIME" || json["code"] == "TOKEN IS EMPTY" {
                    let user = User.read()
                    user?.clear()
                    GLUser = User()
                    window.rootViewController?.presentedViewController?.dismiss(animated: true, completion: nil)
                }
            }
        }
        
        //只有请求错误时会继续往下执行
        guard case let Result.failure(error) = result else { return }
        //弹出并显示错误信息
        let message = error.errorDescription ?? "未知错误"
        
        window.makeToast(message)
    }
    
}





let GLProvider = MoyaProvider<GLService>(requestClosure: CustomPlugin.requestTimeoutClosure, plugins: [
    CustomPlugin(tokenClosure: { return GLUser.token })
    ])


enum GLService {
    // 我的模块
    case login(username: String, password: String)
    case logout(partyId: String)
    case modifyPassword(partyId: String, password: String)
    // 列表
    case todoList(partyId: String, pageSize: String, startIndex: String)
    case completeList(partyId: String, pageSize: String, startIndex: String)
    case searchList(partyId: String, pageSize: String, startIndex: String, executionId: String)
    // 详情
    case estimateDetail(custRequestId: String, takeStatus: String, partyId: String, processExampleId: String, processTaskId: String)
    case priceDetail(custRequestId: String, takeStatus: String, partyId: String, processExampleId: String, processTaskId: String)
    // 提交
    case submitPriceDetail(custRequestId: String, partyName: String, processId: String, processTaskId: String, confirmedMoney: String, appraiseRemarks: String)
    case submitTaskDetail(partyId: String, processId: String, processTaskId: String, executionId: String, confirmedMoney: String, remarks: String, carInfo: String, carType: String)
    
    // 获取新建时选择信息
    case getCarOtherInfo(partyId: String) // 门店 经理 团队主管 业务总监 车辆品牌 车构建 描述信息
    case getCarOtherInfoSub1(partyId: String) // 门店 经理 团队主管 业务总监 车辆品牌
    case getCarOtherInfoSub2(partyId: String) // 门店 经理 团队主管 业务总监
    case getCarOtherInfoSub3(partyId: String) // 车构建 描述信息
    
    case getCarSeries(brandId: String) // 获取车辆系列
    case getCarVersion(seriesId: String) // 获取车辆型号
    
    // 提交创建新的车辆评估
    case submitCreateCarEstimateWithMsg(partyId: String, store: String, boss_party_id: String, executive_party_id: String, director_party_id: String, ower: String, goods_code: String, brand_name: String, brand_name_txt: String, goods_series: String, goods_series_txt: String, goods_style: String, goods_style_txt: String, car_color: String, production_date: String, register_date: String, run_number: String, displacement: String, peccancy: String, peccancy_fraction: String, peccancy_money: String, engine_code: String, frame_code: String, invoice: String, transfer_number: String, year_check: String, insurance_due_date: String, jq_insurance: String, sy_insurance: String, gearbox: String, driving_type: String, keyless_startup: String, cruise_control: String, navigation: String, hpyl: String, chair_type: String, fuel_type: String, skylight: String, air_conditioner: String, other: String, airbag: String, accident: String, accident_level: String, ccrpList: [Any], ccroList: [Any], assessment_name: String, confirmed_money: String, remarks: String)
    /**
     ccrpList:
     
     parts_one_id 一级部件（传汉字）
     parts_two_id 二级部件（传汉字）
     accident_type 描述（传汉字）
     remarks 补充说明
     */
    
    /**
     ccroList:
     
     fileTypeName 文件类型 名称0：车辆外观  1：车辆内饰  2：车辆信息  3：差价查询  4：违章查询
     fileName 文件名称
     fileUrl 文件地址
     fileSize  附件大小
     */
    
    
    
    /// 公共接口
    case getInfoByPid(pid: String) // 根据父节点ID 获取子节点信息
    case uploadFile(multiParts: [MultipartFormData])
    
}

// MARK: - TargetType Protocol Implementation
extension GLService: TargetType {
    var mainURL: String { return "http://192.168.5.90:8080" }
//    var mainURL: String { return "http://192.168.6.226:8080/ROOT" }
    var baseURL: URL { return URL(string: mainURL)! }
    var path: String {
        switch self {
        case .login(_, _):
            return "/api/sys/login.shtml"
        case .logout(_):
            return "/api/sys/logout.shtml"
        case .modifyPassword(_, _):
            return "/api/sys/modifyPassword.shtml"
        case .todoList(_, _, _):
            return "/api/appProcess/work/todo.shtml"
        case .completeList(_, _, _):
            return "/api/appProcess/work/complete.shtml"
        case .searchList(_, _, _, _):
            return "/api/appProcess/work/search.shtml"
        case .estimateDetail(_, _, _, _, _):
            return "/api/appGetBdInfo/getBdInfoData.shtml"
        case .priceDetail(_, _, _, _, _):
            return "/api/appCarAssecc/getCarCollateralData.shtml"
        case .submitPriceDetail(_, _, _, _, _, _):
            return "/api/appCarAssecc/submitCarCollateralData.shtml"
        case .submitTaskDetail(_, _, _, _, _, _, _, _):
            return "/api/appCarAssecc/submitCarCollateralData.shtml"
        case .getCarOtherInfo(_):
            return "/api/appCarAssecc/getStoreAndOthersInfo.shtml"
        case .getCarOtherInfoSub1(_):
            return "/api/appCarAssecc/getStoreAndOthersWidthOutPartInfos.shtml"
        case .getCarOtherInfoSub2(_):
            return "/api/appCarAssecc/getStoreAndUserItems.shtml"
        case .getCarOtherInfoSub3(_):
            return "/api/appCarAssecc/getCarPartsInfo.shtml"
            
        case .getCarSeries(_):
            return "/api/appCarAssecc/getSeriesNameList.shtml"
            
        case .getCarVersion(_):
            return "/api/appCarAssecc/getCarStyleList.shtml"
            
            
        case .submitCreateCarEstimateWithMsg(_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _):
            return "/api/appCarAssecc/addCarAsseccInfo.shtml"
            
        case .getInfoByPid(_):
            return "/api/appCarAssecc/getSysTdDmByPid.shtml"
        
        case .uploadFile(_):
            return "/frame/fileUpload.shtml"
            
        }
        
    }
    var method: Moya.Method {
        return .post
    }
    var task: Task {
        var param = [String: Any]()
        param["header"] = ["channel": "iOS", "token": GLUser.token]
        param["body"] = [String:Any]()
        switch self {
            
        case let GLService.login(username, password):
            param["body"] = ["username": username, "password": password]
        case let GLService.logout(partyId):
            param["body"] = ["partyId": partyId]
        case let GLService.modifyPassword(partyId, password):
            param["body"] = ["partyId": partyId, "password": password]
            
        case let GLService.todoList(partyId, pageSize, startIndex):
            param["body"] = ["partyId": partyId, "pageSize": pageSize, "startIndex": startIndex]
            
        case let GLService.completeList(partyId, pageSize, startIndex):
            param["body"] = ["partyId": partyId, "pageSize": pageSize, "startIndex": startIndex]
            
        case let GLService.searchList(partyId, pageSize, startIndex, executionId):
            param["body"] = ["partyId": partyId, "pageSize": pageSize, "startIndex": startIndex, "executionId": executionId]
        case let GLService.estimateDetail(custRequestId, takeStatus, partyId, processExampleId, processTaskId):
            param["body"] = ["custRequestId": custRequestId, "takeStatus": takeStatus, "partyId": partyId, "processExampleId": processExampleId, "processTaskId": processTaskId]
        case let GLService.priceDetail(custRequestId, takeStatus, partyId, processExampleId, processTaskId):
            param["body"] = ["custRequestId": custRequestId, "takeStatus": takeStatus, "partyId": partyId, "processExampleId": processExampleId, "processTaskId": processTaskId]
            
        case let GLService.submitPriceDetail(custRequestId, partyName, processId, processTaskId, confirmedMoney, appraiseRemarks):
            param["body"] = ["custRequestId": custRequestId, "partyName": partyName, "processId": processId, "processTaskId": processTaskId, "confirmedMoney": confirmedMoney, "appraiseRemarks": appraiseRemarks]
        case let GLService.submitTaskDetail(partyId, processId, processTaskId, executionId, confirmedMoney, remarks, carInfo, carType):
            param["body"] = ["partyId": partyId, "processId": processId, "processTaskId": processTaskId, "executionId": executionId, "confirmedMoney": confirmedMoney, "remarks": remarks, "carInfo": carInfo, "carType": carType]
            
        case let GLService.getCarOtherInfo(partyId):
            param["body"] = ["partyId": partyId]
        case let GLService.getCarOtherInfoSub1(partyId):
            param["body"] = ["partyId": partyId]
        case let GLService.getCarOtherInfoSub2(partyId):
            param["body"] = ["partyId": partyId]
        case let GLService.getCarOtherInfoSub3(partyId):
            param["body"] = ["partyId": partyId]
            
            
        case let GLService.getCarSeries(brandId):
            param["body"] = ["brandId": brandId]
        case let GLService.getCarVersion(seriesId):
            param["body"] = ["seriesId": seriesId]
            
            
        case let GLService.submitCreateCarEstimateWithMsg(partyId, store, boss_party_id, executive_party_id, director_party_id, ower, goods_code, brand_name, brand_name_txt, goods_series, goods_series_txt, goods_style, goods_style_txt, car_color, production_date, register_date, run_number, displacement, peccancy, peccancy_fraction, peccancy_money, engine_code, frame_code, invoice, transfer_number, year_check, insurance_due_date, jq_insurance, sy_insurance, gearbox, driving_type, keyless_startup, cruise_control, navigation, hpyl, chair_type, fuel_type, skylight, air_conditioner, other, airbag, accident, accident_level, ccrpList, ccroList, assessment_name, confirmed_money, remarks):
            
            param["body"] = ["partyId": partyId, "store": store, "boss_party_id": boss_party_id, "executive_party_id": executive_party_id, "director_party_id": director_party_id, "ower": ower, "goods_code": goods_code, "brand_name": brand_name, "brand_name_txt": brand_name_txt, "goods_series": goods_series, "goods_series_txt": goods_series_txt, "goods_style": goods_style, "goods_style_txt": goods_style_txt, "car_color": car_color, "production_date": production_date, "register_date": register_date, "run_number": run_number, "displacement": displacement, "peccancy": peccancy, "peccancy_fraction": peccancy_fraction, "peccancy_money": peccancy_money, "engine_code": engine_code, "frame_code": frame_code, "invoice": invoice, "transfer_number": transfer_number, "year_check": year_check, "insurance_due_date": insurance_due_date, "jq_insurance": jq_insurance, "sy_insurance": sy_insurance, "gearbox": gearbox, "driving_type": driving_type, "keyless_startup": keyless_startup, "cruise_control": cruise_control, "navigation": navigation, "hpyl": hpyl, "chair_type": chair_type, "fuel_type": fuel_type, "skylight": skylight, "air_conditioner": air_conditioner, "other": other, "airbag": airbag, "accident": accident, "accident_level": accident_level, "ccrpList": ccrpList, "ccroList": ccroList, "assessment_name": assessment_name, "confirmed_money": confirmed_money, "remarks": remarks]
            
        case let GLService.getInfoByPid(pid):
            param["body"] = ["pid": pid]
            
            
        case let GLService.uploadFile(multiParts):
            return .uploadMultipart(multiParts)
        }
        return .requestParameters(parameters: ["data": (JSON(param).rawString())!], encoding: URLEncoding.queryString)
    }
    var sampleData: Data {
        return Data()
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}

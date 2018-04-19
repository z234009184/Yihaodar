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
import HandyJSON

struct CustomPlugin: PluginType {
    
    
    static let requestTimeoutClosure = { (endpoint: Endpoint<GLService>, done: @escaping MoyaProvider<GLService>.RequestResultClosure) in
        guard var request = try? endpoint.urlRequest() else { return }
        request.timeoutInterval = 60    //设置请求超时时间
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




/// 请求类
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
    
    /// 通用领单接口
    case taskTakeApp(partyId: String, processExampleId: String, processTaskId: String, taskType: String, l_number: String)
    
    /// 安装GPS、下户、审批、抵押贷款详情页面
    case GPSDetail(partyId: String, l_number: String)
    
    /// 查询已安装GPS信息
    case getInstalledGPSInfo(processTaskId: String)
    
    /// 查询已下户信息
    case getPauperEndInfo(processTaskId: String, l_number: String)
    
    /// 查询已抵质押信息
    case getPledgeEndInfo(partyId: String, processTaskId: String, l_number: String)
    
    /// 获取GPS安装负责人接口
    case getGPSManagersInfo(partyId: String)
    
    /// 提交GPS信息接口
    case submitGPSInfo(partyId: String, processExampleId: String, processTaskId: String, backFlag: String, l_id: String,l_number: String, g_personnel: String, install_Date: String, gpsList: [Any])
    
    /// 提交下户信息
    case submitPauperInfo(partyId: String, processId: String, processTaskId: String, fallbackf: String, crea_date: String, pauper_agreement: String, pauper_source: String, pauper_contraband: String, pauper_environment: String, pauper_purpose: String, pauper_opinion: String, l_number: String, p_id: String, fileInfo: [Any])
    
    /// 提交抵质押信息
    case submitPledgeInfo(partyId: String, processExampleId: String, processTaskId: String, backFlag: String, crea_date: String, l_id: String, attachmentList: [Any])
    
    
    /// 审批
    case submitApprove(partyId: String, processId: String, processTaskId: String, l_number: String, lend_apply_id: String, exam_status: String, remarks: String)
    
    
    // -- 回退流程
    /// 查看GPS回退
    case backGPSProcess(l_number: String)
    
    /// 查询下户回退
    case backPauperProcess(l_number: String)
    
    /// 查询抵质押回退
    case backPledgeProcess(l_number: String)
    
}


// MARK: - TargetType Protocol Implementation
extension GLService: TargetType {
    
    #if DEVELOPMENT
    var mainURL: String { return "http://192.168.5.235:8080" } // 开发模式
    #else
    var mainURL: String { return "http://yijiaren.yihaodar.com" } // 生产模式
    #endif
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
            return "/api/appProcess/add/submission.shtml"
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
            
        case .taskTakeApp(_, _, _, _, _):
            return "/api/appProcess/taskTakeApp.shtml"
            
            
        case .GPSDetail(_, _):
            return "/api/loan/toLoanDetail.shtml"
            
        case .getInstalledGPSInfo(_):
            return "/api/appGetGps/gpsEndAPP.shtml"
        
        case .getPauperEndInfo(_, _):
            return "/api/appPauper/pauperEnd.shtml"
           
        case .getPledgeEndInfo(_, _, _):
            return "/api/appGetPledge/pledgeEndAPP.shtml"
            
        case .getGPSManagersInfo(_):
            return "/api/appGetGps/getGpsManApp.shtml"
            
        case .submitGPSInfo(_, _, _, _, _, _, _, _, _):
            return "/api/appGetGps/saveGpsAPP.shtml"
            
        case .submitPauperInfo(_, _, _, _, _, _, _, _, _, _, _, _, _, _):
            return "/api/appPauper/addPauperInfo.shtml"
            
        case .submitPledgeInfo(_, _, _, _, _, _, _):
            return "/api/appGetPledge/savePledgeAPP.shtml"
            
        case .submitApprove(_, _, _, _, _, _, _):
            return "/api/appLoanShengPi/submitLoanShengPi.shtml"
            
        case .backGPSProcess(_):
            return "/api/appGetGps/backGpsProcessApp.shtml"
            
            
        case .backPauperProcess(_):
            return "/api/appPauper/pauperBack.shtml"
            
        case .backPledgeProcess(_):
            return "/api/appPauper/backProcessApp.shtml"
            
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
            break
        case let GLService.logout(partyId):
            param["body"] = ["partyId": partyId]
            break
        case let GLService.modifyPassword(partyId, password):
            param["body"] = ["partyId": partyId, "password": password]
            break
        case let GLService.todoList(partyId, pageSize, startIndex):
            param["body"] = ["partyId": partyId, "pageSize": pageSize, "startIndex": startIndex]
            break
        case let GLService.completeList(partyId, pageSize, startIndex):
            param["body"] = ["partyId": partyId, "pageSize": pageSize, "startIndex": startIndex]
            break
        case let GLService.searchList(partyId, pageSize, startIndex, executionId):
            param["body"] = ["partyId": partyId, "pageSize": pageSize, "startIndex": startIndex, "executionId": executionId]
            break
        case let GLService.estimateDetail(custRequestId, takeStatus, partyId, processExampleId, processTaskId):
            param["body"] = ["custRequestId": custRequestId, "takeStatus": takeStatus, "partyId": partyId, "processExampleId": processExampleId, "processTaskId": processTaskId]
            break
        case let GLService.priceDetail(custRequestId, takeStatus, partyId, processExampleId, processTaskId):
            param["body"] = ["custRequestId": custRequestId, "takeStatus": takeStatus, "partyId": partyId, "processExampleId": processExampleId, "processTaskId": processTaskId]
            break
        case let GLService.submitPriceDetail(custRequestId, partyName, processId, processTaskId, confirmedMoney, appraiseRemarks):
            param["body"] = ["custRequestId": custRequestId, "partyName": partyName, "processId": processId, "processTaskId": processTaskId, "confirmedMoney": confirmedMoney, "appraiseRemarks": appraiseRemarks]
            break
        case let GLService.submitTaskDetail(partyId, processId, processTaskId, executionId, confirmedMoney, remarks, carInfo, carType):
            param["body"] = ["partyId": partyId, "processId": processId, "processTaskId": processTaskId, "executionId": executionId, "confirmedMoney": confirmedMoney, "remarks": remarks, "carInfo": carInfo, "carType": carType]
            break
        case let GLService.getCarOtherInfo(partyId):
            param["body"] = ["partyId": partyId]
            break
        case let GLService.getCarOtherInfoSub1(partyId):
            param["body"] = ["partyId": partyId]
            break
        case let GLService.getCarOtherInfoSub2(partyId):
            param["body"] = ["partyId": partyId]
            break
        case let GLService.getCarOtherInfoSub3(partyId):
            param["body"] = ["partyId": partyId]
            break
            
        case let GLService.getCarSeries(brandId):
            param["body"] = ["brandId": brandId]
            break
        case let GLService.getCarVersion(seriesId):
            param["body"] = ["seriesId": seriesId]
            break
            
        case let GLService.submitCreateCarEstimateWithMsg(partyId, store, boss_party_id, executive_party_id, director_party_id, ower, goods_code, brand_name, brand_name_txt, goods_series, goods_series_txt, goods_style, goods_style_txt, car_color, production_date, register_date, run_number, displacement, peccancy, peccancy_fraction, peccancy_money, engine_code, frame_code, invoice, transfer_number, year_check, insurance_due_date, jq_insurance, sy_insurance, gearbox, driving_type, keyless_startup, cruise_control, navigation, hpyl, chair_type, fuel_type, skylight, air_conditioner, other, airbag, accident, accident_level, ccrpList, ccroList, assessment_name, confirmed_money, remarks):
            
            param["body"] = ["partyId": partyId, "store": store, "boss_party_id": boss_party_id, "executive_party_id": executive_party_id, "director_party_id": director_party_id, "ower": ower, "goods_code": goods_code, "brand_name": brand_name, "brand_name_txt": brand_name_txt, "goods_series": goods_series, "goods_series_txt": goods_series_txt, "goods_style": goods_style, "goods_style_txt": goods_style_txt, "car_color": car_color, "production_date": production_date, "register_date": register_date, "run_number": run_number, "displacement": displacement, "peccancy": peccancy, "peccancy_fraction": peccancy_fraction, "peccancy_money": peccancy_money, "engine_code": engine_code, "frame_code": frame_code, "invoice": invoice, "transfer_number": transfer_number, "year_check": year_check, "insurance_due_date": insurance_due_date, "jq_insurance": jq_insurance, "sy_insurance": sy_insurance, "gearbox": gearbox, "driving_type": driving_type, "keyless_startup": keyless_startup, "cruise_control": cruise_control, "navigation": navigation, "hpyl": hpyl, "chair_type": chair_type, "fuel_type": fuel_type, "skylight": skylight, "air_conditioner": air_conditioner, "other": other, "airbag": airbag, "accident": accident, "accident_level": accident_level, "ccrpList": ccrpList, "ccroList": ccroList, "assessment_name": assessment_name, "confirmed_money": confirmed_money, "remarks": remarks]
            break
            
        case let GLService.getInfoByPid(pid):
            param["body"] = ["pid": pid]
            break
        case let GLService.uploadFile(multiParts):
            return .uploadMultipart(multiParts)
            
        case let GLService.taskTakeApp(partyId, processExampleId, processTaskId, taskType, l_number):
            param["body"] = ["partyId": partyId, "processExampleId": processExampleId, "processTaskId": processTaskId, "taskType": taskType, "l_number": l_number]
            break
        case let GLService.GPSDetail(partyId, l_number):
            param["body"] = ["partyId": partyId, "l_number": l_number]
            break
        case let GLService.getInstalledGPSInfo(processTaskId):
            param["body"] = ["processTaskId": processTaskId]
            break
            
        case let GLService.getPauperEndInfo(processTaskId, l_number):
            param["body"] = ["processTaskId": processTaskId, "l_number": l_number]
            break
            
        case let GLService.getPledgeEndInfo(partyId, processTaskId, l_number):
            param["body"] = ["partyId": partyId, "processTaskId": processTaskId, "l_number": l_number]
            break
            
        case let GLService.getGPSManagersInfo(partyId):
            param["body"] = ["partyId": partyId]
            break
            
        case let GLService.submitGPSInfo(partyId, processExampleId, processTaskId, backFlag, l_id, l_number, g_personnel, install_Date, gpsList):
            param["body"] = ["partyId": partyId, "processExampleId": processExampleId, "processTaskId": processTaskId, "backFlag": backFlag, "l_id": l_id, "l_number": l_number, "g_personnel": g_personnel, "install_Date": install_Date, "gpsList": gpsList]
            break
            
        case let GLService.submitPauperInfo(partyId, processId, processTaskId, fallbackf, crea_date, pauper_agreement, pauper_source, pauper_contraband, pauper_environment, pauper_purpose, pauper_opinion, l_number, p_id, fileInfo):
            param["body"] = ["partyId": partyId, "processId": processId, "processTaskId": processTaskId, "fallbackf": fallbackf, "crea_date": crea_date, "pauper_agreement": pauper_agreement, "pauper_source": pauper_source, "pauper_contraband": pauper_contraband, "pauper_environment": pauper_environment, "pauper_purpose": pauper_purpose, "pauper_opinion": pauper_opinion, "l_number": l_number, "p_id": p_id, "fileInfo": fileInfo]
            break
            
        case let GLService.submitPledgeInfo(partyId, processExampleId, processTaskId, backFlag, crea_date, l_id, attachmentList):
            param["body"] = ["partyId": partyId, "processExampleId": processExampleId, "processTaskId": processTaskId, "backFlag": backFlag, "crea_date": crea_date, "l_id": l_id, "attachmentList": attachmentList]
            break
            
            
        case let GLService.submitApprove(partyId, processId, processTaskId, l_number, lend_apply_id, exam_status, remarks):
            param["body"] = ["partyId": partyId, "processId": processId, "processTaskId": processTaskId, "l_number": l_number, "lend_apply_id": lend_apply_id, "exam_status": exam_status, "remarks": remarks]
            break
            
        case let GLService.backGPSProcess(l_number):
            param["body"] = ["l_number": l_number]
            break
            
        case let GLService.backPauperProcess(l_number):
            param["body"] = ["l_number": l_number]
            break
            
            
        case let GLService.backPledgeProcess(l_number):
            param["body"] = ["l_number": l_number]
            break
            
            
        }
        
        var resultStr = (JSON(param).rawString(options: []))!.replacingOccurrences(of: "\\", with: "")
        resultStr = resultStr.replacingOccurrences(of: "＼", with: "")
        
        print(resultStr)
        return .requestParameters(parameters: ["data": resultStr], encoding: URLEncoding.queryString)
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

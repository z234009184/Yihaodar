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

struct CostumPlugin: PluginType {
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
                if json["code"] == "TOKEN IS ERROR" {
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


let GLProvider = MoyaProvider<GLService>(plugins: [
    CostumPlugin(tokenClosure: { return GLUser.token })
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
    
    
}

// MARK: - TargetType Protocol Implementation
extension GLService: TargetType {
    var mainURL: String { return "http://192.168.5.90:8080" }
//    var mainURL: String { return "http://httpbin.org" }
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
            
            
        }
    }
    var method: Moya.Method {
        return .post
    }
    var task: Task {
        var param = [String:Any]()
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

//
//  GLService.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/28.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Moya
import SwiftyJSON


/// token字符串
var tokenString: String?

struct AuthPlugin: PluginType {
    let tokenClosure: () -> String?
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        //获取获取令牌字符串
        if let token = tokenClosure() {
            //将token添加到请求头中
            request.addValue(token, forHTTPHeaderField: "token")
            request.addValue("iOS", forHTTPHeaderField: "channel")
            
        }
        return request
        
        
    }
    func willSend(_ request: RequestType, target: TargetType) {
        
    }
    
}


let GLProvider = MoyaProvider<GLService>(plugins: [
    AuthPlugin(tokenClosure: { return tokenString })
    ])


enum GLService {
    case login(username: String, password: String)
    case todoList(partyId: String, pageSize: String, startIndex: String)
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
        case .todoList(_, _, _):
            return "/api/appProcess/work/todo.shtml"
        }
    }
    var method: Moya.Method {
        return .post
    }
    var task: Task {
        var param = [String:Any]()
        param["header"] = ["channel": "iOS", "token": tokenString]
        param["body"] = [String:Any]()
        switch self {
        case let .login(username, password):
            param["body"] = ["username": username, "password": password]
        case let .todoList(partyId, pageSize, startIndex):
            param["body"] = ["partyId": partyId, "pageSize": pageSize, "startIndex": startIndex]
            
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

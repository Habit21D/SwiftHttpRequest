//
//  NetworkTools.swift
//  HttpRequest
//
//  Created by JIN on 2017/6/22.
//  Copyright © 2017年 jin. All rights reserved.
//  网络层封装

import Foundation
import Alamofire

enum MethodType {
    case get
    case post
}

//一次封装
class NetworkTools {
    
    /// 请求方法 返回值JSON
    ///
    /// - Parameters:
    ///   - type: 请求类型
    ///   - URLString: 链接
    ///   - params: 参数
    ///   - success: 成功的回调
    ///   - failture: 失败的回调
    class func request(_ type : MethodType = .post, url : String, params : [String : Any]?,success : @escaping (_ data : Data)->(), failure : ((Int?, String) ->Void)?) {
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        // 2.发送网络请求
        TProgressHUD.show()
         Alamofire.request(url, method: method, parameters: params).responseData { (response) in
            TProgressHUD.hide()
            guard let json = response.data else {
                return
            }
            switch response.result {
            case let .success(response):
                do {
                    // ***********这里可以统一处理错误码，统一弹出错误 ****
                    let decoder = JSONDecoder()
                    let baseModel = try? decoder.decode(BaseModel.self, from: json)
                    guard let model = baseModel else {
                        failure?(nil, "解析失败")
                        return
                    }
                    switch (model.generalCode) {
                    case HttpCode.success.rawValue :
                        //数据返回正确
                        success(json)
                    case HttpCode.needLogin.rawValue:
                        //请重新登录
                        failure?(model.generalCode ,model.generalMessage)
                        alertLogin(model.generalMessage)
                    default:
                        //其他错误
                        failureHandle(failure: failure, stateCode: model.generalCode, message: model.generalMessage)
                    }
                }
            case let .failure(error):
                failureHandle(failure: failure, stateCode: nil, message: error.localizedDescription)
            }
        }
        
        //错误处理 - 弹出错误信息
        func failureHandle(failure: ((Int?, String) ->Void)? , stateCode: Int?, message: String) {
            TAlert.show(type: .error, text: message)
            failure?(stateCode ,message)
        }
        
        //登录弹窗 - 弹出是否需要登录的窗口
        func alertLogin(_ title: String?) {
            //TODO: 跳转到登录页的操作：
        }
    }
}

//二次封装
extension NetworkTools{
    
    /// GET 请求 返回JSON
    ///
    /// - Parameters:
    ///   - URLString: 请求链接
    ///   - params: 参数
    ///   - success: 成功的回调
    ///   - failture: 失败的回调
    class func GET(url : String, params : [String : Any]?,success : @escaping (_ data : Data)->(), failure : ((Int?, String) ->Void)?) {
        NetworkTools.request(.get, url: url, params: params, success: success, failure: failure)
    }
    
    
    /// POST 求情
    ///
    /// - Parameters:
    ///   - URLString: 请求链接
    ///   - params: 参数
    ///   - success: 成功的回调
    ///   - failture: 失败的回调
    class func POST(url : String, params : [String : Any]?,success : @escaping (_ data : Data) ->(), failure : ((Int?, String) ->Void)?) {
        NetworkTools.request(.post, url: url, params: params,success: success, failure: failure)
    }
    
    
}

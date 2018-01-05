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
    class func request(_ type : MethodType = .post, url : String, params : [String : Any]?,success : @escaping (_ data : Data)->(), failture : @escaping (_ error : NSError)->()) {
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        // 2.发送网络请求
        TProgressHUD.show()
         Alamofire.request(url, method: method, parameters: params).responseData { (response) in
            TProgressHUD.hide()
            switch response.result {
            case.success:
                if let value = response.result.value {
                    success(value)
                }
                //可进行错误码的统一处理
            case .failure(let error):
                failture(error as NSError)
            }
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
    class func GET(url : String, params : [String : Any]?,success : @escaping (_ data : Data)->(), failture : @escaping (_ error : NSError)->()) {
        NetworkTools.request(.get, url: url, params: params, success: success, failture: failture)
    }
    
    
    /// POST 求情
    ///
    /// - Parameters:
    ///   - URLString: 请求链接
    ///   - params: 参数
    ///   - success: 成功的回调
    ///   - failture: 失败的回调
    class func POST(url : String, params : [String : Any]?,success : @escaping (_ data : Data) ->(), failture : @escaping (_ error : NSError)->()) {
        NetworkTools.request(.post, url: url, params: params,success: success, failture: failture)
    }
    
    
}

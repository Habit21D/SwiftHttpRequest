//
//  NetworkTools.swift
//  HttpRequest
//
//  Created by JIN on 2017/6/22.
//  Copyright © 2017年 JIN. All rights reserved.
//

import Foundation
import Alamofire

enum MethodType {
    case get
    case post
}

/*
 这里的封装具有针对性，因为返回String类型的话比较方便HandyJSON的处理
 而返回JSON类型是为了以备不时之需（比如有同学使用SwiftyJSON），所以默认值到String
 Alamofire本身提供多种类型response
 */
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
    class func requestDataToJSON(_ type : MethodType = .post, URLString : String, params : [String : Any]?,success : @escaping (_ responseObject : [String:Any])->(), failture : @escaping (_ error : NSError)->()) {
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        // 2.发送网络请求
         Alamofire.request(URLString, method: method, parameters: params).responseJSON { (response) in
            switch response.result {
            case.success:
                if let value = response.result.value as? [String : AnyObject] {
                    success(value)
                }
            case .failure(let error):
                failture(error as NSError)
            }
        }
        
    }
 
    /// 请求方法 返回值String
    class func requestDataToString(_ type : MethodType = .post, URLString : String, params : [String : Any]?,success : @escaping (_ responseObject : String)->(), failture : @escaping (_ error : NSError)->()) {
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        // 2.发送网络请求
        Alamofire.request(URLString, method: method, parameters: params).responseString { (response) in
            switch response.result {
            case.success:
                if let value = response.result.value{
                    success(value)
                }
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
    class func GETJSON(URLString : String, params : [String : Any]?,success : @escaping (_ responseObject : [String:Any])->(), failture : @escaping (_ error : NSError)->()) {
        NetworkTools.requestDataToJSON(.get, URLString: URLString, params: params, success: success, failture: failture)
    }
    
    //GET请求 返回String
    class func GET(URLString : String, params : [String : Any]?,success : @escaping (_ responseObject : String)->(), failture : @escaping (_ error : NSError)->()) {
        NetworkTools.requestDataToString(.get, URLString: URLString, params: params, success: success, failture: failture)
    }
    
    
    /// POST 求情
    ///
    /// - Parameters:
    ///   - URLString: 请求链接
    ///   - params: 参数
    ///   - success: 成功的回调
    ///   - failture: 失败的回调
    class func POSTJSON(URLString : String, params : [String : Any]?,success : @escaping (_ responseObject :[String:Any])->(), failture : @escaping (_ error : NSError)->()) {
        NetworkTools.requestDataToJSON(.post, URLString: URLString, params: params,success: success, failture: failture)
    }
    
    //post请求 返回String
    class func POST(URLString : String, params : [String : Any]?,success : @escaping (_ responseObject : String)->(), failture : @escaping (_ error : NSError)->()) {
        NetworkTools.requestDataToString(.post, URLString: URLString, params: params, success: success, failture: failture)
    }
    
}

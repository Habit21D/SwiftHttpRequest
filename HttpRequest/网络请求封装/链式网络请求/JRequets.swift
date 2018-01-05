//
//  JRequets.swift
//  YJRequest
//
//  Created by JIN on 2017/6/23.
//  Copyright © 2017年 jin. All rights reserved.
//  网络层封装

import Foundation
import Alamofire

enum HttpRequestType {
    case get
    case post
}

//Networkkit属性设置
class NetworkKit {
    
    typealias SuccessHandlerType = ((Data) -> Void)
    typealias FailureHandlerType = ((NSError?) -> Void)
    
    var requestType: HttpRequestType = .post//请求类型
    var url: String?//URL
    var params: [String: Any]?//参数
    var successHandler: SuccessHandlerType?//成功的回调
    var failureHandler: FailureHandlerType?//失败的回调
    var httpRequest: Request?
    
    
}

//NetworkKit属性的设置
extension NetworkKit{
    
    func url(_ url: String?) -> Self {
        self.url = url
        return self
    }
    
    func requestType(_ type:HttpRequestType) -> Self {
        self.requestType = type
        return self
    }
    
    func params(_ params: [String: Any]?) -> Self {
        self.params = params
        return self
    }
    
    func success(_ handler: @escaping SuccessHandlerType) -> Self {
        self.successHandler = handler
        return self
    }
    
    func failure(handler: @escaping FailureHandlerType) -> Self {
        self.failureHandler = handler
        return self
    }
    
}

//NetworkKit请求相关，设置好相关参数后再调用
/*
 这里的封装具有针对性，因为返回String类型的话比较方便HandyJSON的处理
 而返回JSON类型是为了以备不时之需（比如有同学使用SwiftyJSON），所以默认值到String
 Alamofire本身提供多种类型response
 */
extension NetworkKit{
    
    //发起请求，并处理请求结果--处理成字符串还是JSON
    func request() -> Void {
        var dataRequest: DataRequest?//alamofire请求后的返回值
        
        //发起请求
        if let URLString = url {
            TProgressHUD.show()
            let method = requestType == .get ? HTTPMethod.get : HTTPMethod.post
            dataRequest =  Alamofire.request(URLString, method: method, parameters: params)
        }
        
        dataRequest?.responseData {
            (response) in
            TProgressHUD.hide()
            switch response.result {
            case.success:
                if let value = response.result.value{
                    self.successHandler?(value)
                }
                //可进行错误码统一处理
            case .failure(let error):
                self.failureHandler?(error as NSError)
                
            }
        }
    }
    
    //取消请求
    func cancel() {
        httpRequest?.cancel()
    }
    
}


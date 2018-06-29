//
//  HttpRequest.swift
//  JSONToModel
//
//  Created by jin on 2017/12/15.
//  Copyright © 2017年 jin. All rights reserved.
//

import Foundation
import Moya
import MBProgressHUD

///错误码 根据自家后台数据确定
let NET_STATE_CODE_SUCCESS = 0
let NET_STATE_CODE_LOGIN = 4000

class TBaseModel: Decodable {
    var dm_error: Int
    var error_msg: String
}

class HttpRequest {
    /// 使用moya的请求封装
    ///
    /// - Parameters:
    ///   - API: 要使用的moya请求枚举（TargetType）
    ///   - target: TargetType里的枚举值
    ///   -cache: 是否缓存
    ///   -cacheHandle: 需要单独处理缓存的数据时使用，（默认为空，使用success处理缓存数据）
    ///   - success: 成功的回调
    ///   - error: 连接服务器成功但是数据获取失败
    ///   - failure: 连接服务器失败
    class func loadData<T: TargetType>(API: T.Type, target: T, cache: Bool = false, cacheHandle: ((Data) -> Void)? = nil, success: @escaping((Data) -> Void), failure: ((Int?, String) ->Void)? ) {
        let provider = MoyaProvider<T>()
        
        if cache, let data = TSaveFiles.read(path: target.path) {
            if let block = cacheHandle {
                block(data)
            }else {
                success(data)
            }
        }else {
            TProgressHUD.show()
        }
        
        provider.request(target) { result in
            TProgressHUD.hide()
            switch result {
            case let .success(response):
                do {
                    // ***********这里可以统一处理错误码，统一弹出错误 ****
                    let _ = try response.filterSuccessfulStatusCodes()
                    
                    let decoder = JSONDecoder()
                    let baseModel = try? decoder.decode(TBaseModel.self, from: response.data)
                    guard let model = baseModel else {
                        if let failureBlack = failure {
                            failureBlack(nil, "解析失败")
                        }
                        return
                    }
                    switch (model.dm_error) {
                    case NET_STATE_CODE_SUCCESS :
                        //数据返回正确
                        if cache {
                            //缓存
                            TSaveFiles.save(path: target.path, data: response.data)
                        }
                        success(response.data)
                        break
                    case NET_STATE_CODE_LOGIN:
                        //请重新登录
                        if let failureBlack = failure {
                            failureBlack(model.dm_error ,model.error_msg)
                        }
                        alertLogin(model.error_msg)
                        break
                    default:
                        //其他错误
                        failureHandle(failure: failure, stateCode: nil, message: model.error_msg)
                        break
                    }
                }
                catch let error {
                    guard let error = error as? MoyaError else { return }
                    let statusCode = error.response?.statusCode ?? 0
                    let errorCode = "请求出错，错误码：" + String(statusCode)
                    failureHandle(failure: failure, stateCode: statusCode, message: error.errorDescription ?? errorCode)
                }
            // ********************
            case .failure(_):
                failureHandle(failure: failure, stateCode: nil, message: "网络异常")
            }
        }
        
        //错误处理 - 弹出错误信息
        func failureHandle(failure: ((Int?, String) ->Void)? , stateCode: Int?, message: String) {
            TAlert.show(type: .error, text: message)
            if let failureBlack = failure {
                failureBlack(nil ,message)
            }
        }
        
        //登录弹窗 - 弹出是否需要登录的窗口
        func alertLogin(_ title: String?) {
            //TODO: 跳转到登录页的操作：
        }
    }
}


//一次性处理的参数
public extension TargetType {
    var baseURL: URL {
        return URL(string: "http://v5.pc.duomi.com/")!
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    var method: Moya.Method {
        return .post
    }
    
    
}




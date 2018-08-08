//
//  HttpRequest.swift
//  JSONToModel
//
//  Created by jin on 2017/12/15.
//  Copyright © 2017年 jin. All rights reserved.
//  moya封装

import Foundation
import Moya
import MBProgressHUD

///状态码 根据自家后台数据更改
let NET_STATE_CODE_SUCCESS = 1
let NET_STATE_CODE_LOGIN = 4000

struct TBaseModel: Decodable {
    var code: Int
    var data: Data
    struct Data: Decodable {
        var stateCode: Int
        var message: String
    }
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
        let provider = MoyaProvider<T>(plugins: [
            RequestHandlingPlugin()
            ])
        
        //如果需要读取缓存，则优先读取缓存内容
        if cache, let data = TSaveFiles.read(path: target.path) {
            //cacheHandle不为nil则使用cacheHandle处理缓存，否则使用success处理
            if let block = cacheHandle {
                block(data)
            }else {
                success(data)
            }
        }else {
            //读取缓存速度较快，无需显示hud；仅从网络加载数据时，显示hud。
            TProgressHUD.show()
        }
        
        provider.request(target) { result in
            TProgressHUD.hide()
            switch result {
            case let .success(response):
                // ***********  这里可以统一处理状态码 ****
                //从json中解析出status_code状态码和message，用于后面的处理
                let decoder = JSONDecoder()
                let baseModel = try? decoder.decode(TBaseModel.self, from: response.data)
                guard let model = baseModel else {
                    if let failureBlack = failure {
                        failureBlack(nil, "数据解析失败")
                    }
                    return
                }
                
                //状态码：后台会规定数据正确的状态码，未登录的状态码等，可以统一处理
                switch (model.code) {
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
                        failureBlack(model.data.stateCode ,model.data.message)
                    }
                    alertLogin(model.data.message)
                    break
                default:
                    //其他错误
                    failureHandle(failure: failure, stateCode: model.data.stateCode, message: model.data.message)
                    break
                }
            // ********************
            case let .failure(error):
                //请求数据失败，可能是404（无法找到指定位置的资源），408（请求超时）等错误
                //可百度查找“http状态码”
                let statusCode = error.response?.statusCode ?? 0
                let errorCode = "请求出错，错误码：" + String(statusCode)
                failureHandle(failure: failure, stateCode: statusCode, message: error.errorDescription ?? errorCode)
            }
        }
        
        //错误处理 - 弹出错误信息
        func failureHandle(failure: ((Int?, String) ->Void)? , stateCode: Int?, message: String) {
            TAlert.show(type: .error, text: message)
            if let failureBlack = failure {
                failureBlack(stateCode ,message)
            }
        }
        
        //登录弹窗 - 弹出是否需要登录的窗口
        func alertLogin(_ title: String?) {
            //TODO: 跳转到登录页的操作：
        }
    }
}


//TargetType协议可以一次性处理的参数
//根据自己的需要更改，不能统一处理的移除下面的代码
public extension TargetType {
    var baseURL: URL {
        return URL(string: "http://app.u17.com/v3/appV3_3/ios/phone/")!
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

// --- 公共参数 ----
class RequestHandlingPlugin: PluginType {
    
    /// Called to modify a request before sending
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var mutateableRequest = request
        return mutateableRequest.appendCommonParams();
    }
}

extension URLRequest {
    
    /// global common params
    private var commonParams: [String: Any] {
        //所有接口的公共参数添加在这里
        return ["token": "",
                "version": ""
        ]
    }
    
    mutating func appendCommonParams() -> URLRequest {
        let request = try? encoded(parameters: commonParams, parameterEncoding: URLEncoding(destination: .queryString))
        assert(request != nil, "append common params failed, please check common params value")
        return request!
    }
    
    func encoded(parameters: [String: Any], parameterEncoding: ParameterEncoding) throws -> URLRequest {
        do {
            return try parameterEncoding.encode(self, with: parameters)
        } catch {
            throw MoyaError.parameterEncoding(error)
        }
    }
}

// --- 公共参数end ----


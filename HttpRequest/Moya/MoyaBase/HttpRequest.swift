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

public class HttpRequest {
    /// 使用moya的请求封装
    ///
    /// - Parameters:
    ///   - target: TargetType里的枚举值
    ///   -cache: 是否缓存
    ///   -cacheHandle: 需要单独处理缓存的数据时使用，（默认为空，使用success处理缓存数据）
    ///   - success: 成功的回调
    ///   - error: 连接服务器成功但是数据获取失败
    ///   - failure: 连接服务器失败
   public class func loadData<T: TargetType>(target: T, cache: Bool = false, cacheHandle: ((Data) -> Void)? = nil, success: @escaping((Data) -> Void), failure: ((Int?, String) ->Void)? ) {
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
                let baseModel = try? decoder.decode(BaseModel.self, from: response.data)
                guard let model = baseModel else {
                    failure?(nil, "数据解析失败")
                    return
                }
                
                //状态码：后台会规定数据正确的状态码，未登录的状态码等，可以统一处理
                switch (model.generalCode) {
                case HttpCode.success.rawValue :
                    //数据返回正确
                    if cache {
                        //缓存
                        TSaveFiles.save(path: target.path, data: response.data)
                    }
                    success(response.data)
                case HttpCode.needLogin.rawValue:
                    //请重新登录
                    failure?(model.generalCode ,model.generalMessage)
                    alertLogin(model.generalMessage)
                default:
                    //其他错误
                    failureHandle(failure: failure, stateCode: model.generalCode, message: model.generalMessage)
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
            failure?(stateCode ,message)
        }
        
        //登录弹窗 - 弹出是否需要登录的窗口
        func alertLogin(_ title: String?) {
            //TODO: 跳转到登录页的操作：
        }
    }
}

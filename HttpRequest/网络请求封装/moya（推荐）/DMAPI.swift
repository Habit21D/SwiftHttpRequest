//
//  DMAPI.swift
//  HttpRequest
//
//  Created by 易金 on 2018/1/5.
//  Copyright © 2018年 jin. All rights reserved.
//

import Foundation
import Moya

enum  DMAPI {
    ///搜索
    case search(kw: String ,pi: Int, pz: Int)
    
    ///其他接口...
    case other1(param: String)
    case other2

}

// 补全HttpRequest.swift中没有处理的参数 
extension DMAPI: TargetType {
    
    var path: String {
        switch self {
        case .search:
            return "search-ajaxsearch-searchall"
        case .other1:
            return ""
        case .other2:
            return ""
        }
    }
    
    var task: Task {
        var params: [String: Any] = [:]
        
        switch self {
        case let .search(kw ,pi, pz):
            params["kw"] = kw
            params["pi"] = pi
            params["pz"] = pz
            
        case let .other1(param):
            params["param"] = param
            
        default:
            //不需要传参数的接口走这里
            return .requestPlain
        }
        
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
}

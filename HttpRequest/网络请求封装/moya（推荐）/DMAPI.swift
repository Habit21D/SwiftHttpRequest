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
}

extension DMAPI: TargetType {
    
    var path: String {
        switch self {
        case .search:
            return "search-ajaxsearch-searchall"
        }
    }
    
    var task: Task {
        var params: [String: Any] = [:]
        
        switch self {
        case let .search(kw ,pi, pz):
            params["kw"] = kw
            params["pi"] = pi
            params["pz"] = pz
        }
        
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
}

//
//  MyAPI.swift
//  HttpRequest
//
//  Created by apple on 2017/8/3.
//  Copyright © 2017年 JIN. All rights reserved.
//

import Foundation
import Moya
import Alamofire

enum MyAPI {
    case testGet
}

extension MyAPI:TargetType {
    var baseURL: URL {
        return URL(string: URL_Alamofire_test)!
    }
    
    var path: String {
        switch self {
        case .testGet:
            return ""

        }
    }
    
    var method: Moya.Method {
        switch self {
        case .testGet:
            return .get

        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .testGet:
            return nil

        }
    }
    
     var parameterEncoding: ParameterEncoding {
        return URLEncoding.default

    }
    
    var sampleData: Data {
        switch self {
         case .testGet:
            return "[{\"name\": \"Repo Name\"}]".data(using: String.Encoding.utf8)!
        }
    }
    
    var task: Task {
        return .request
    }
}

//  moya的一个具体的接口实现

import Foundation
import Moya

enum  DMAPI {
    //排行榜
    case rankList
    
    ///其他接口...
    case other1(param: String)
    case other2

}

// 补全【MoyaConfig 3：配置TargetType协议可以一次性处理的参数】中没有处理的参数
extension DMAPI: TargetType {
    //1. 每个接口的相对路径
    //请求时的绝对路径是   baseURL + path
    var path: String {
        switch self {
        case .rankList:
            return "rank/list"
        case .other1:
            return ""
        case .other2:
            return ""
        }
    }

    //2. 每个接口要使用的请求方式
    var method: Moya.Method {
        switch self {
        case .rankList:
            return .post
        case .other1:
            return .post
        case .other2:
            return .get
        }
    }

    //3. Task是一个枚举值，根据后台需要的数据，选择不同的http task。
    var task: Task {
        var params: [String: Any] = [:]
        switch self {
        case .rankList:
            return .requestPlain
        case let .other1(param):
            params["param"] = param
        default:
            //不需要传参数的接口走这里
            return .requestPlain
        }
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
}

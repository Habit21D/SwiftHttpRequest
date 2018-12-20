import Foundation
import Moya

#warning("下面的代码需要根据项目进行更改")
/**
 1.状态码 根据自家后台数据更改

 - Todo: 根据自己的需要更改
 **/
enum HttpCode : Int {
    case success = 1 //请求成功的状态吗
    case needLogin = -1  // 返回需要登录的错误码
}

/**
 2.为了统一处理错误码和错误信息，在请求回调里会用这个model尝试解析返回值
 - Todo: 根据自家后台更改。
 **/
struct BaseModel: Decodable {
    var code: Int
    var data: Content
    struct Content: Decodable {
        var message: String
    }
}

//下面的错误码及错误信息用来在HttpRequest中使用
extension BaseModel {
    var generalCode: Int {
        return code
    }

    var generalMessage: String {
        return data.message
    }
}

/**
 3.配置TargetType协议可以一次性处理的参数

 - Todo: 根据自己的需要更改，不能统一处理的移除下面的代码，并在DMAPI中实现

 **/
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
}

/**
 4.公共参数

 - Todo: 配置公共参数，例如所有接口都需要传token，version，time等，就可以在这里统一处理

 - Note: 接口传参时可以覆盖公共参数。下面的代码只需要更改 【private var commonParams: [String: Any]?】

 **/
extension URLRequest {
    //TODO：处理公共参数
    private var commonParams: [String: Any]? {
        //所有接口的公共参数添加在这里例如：
        //        return ["token": "",
        //                "version": "ios 1.0.0"
        //        ]
        return nil
    }
}

//下面的代码不更改
class RequestHandlingPlugin: PluginType {
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var mutateableRequest = request
        return mutateableRequest.appendCommonParams();
    }
}

//下面的代码不更改
extension URLRequest {
    mutating func appendCommonParams() -> URLRequest {
        let request = try? encoded(parameters: commonParams, parameterEncoding: URLEncoding(destination: .queryString))
        assert(request != nil, "append common params failed, please check common params value")
        return request!
    }

    func encoded(parameters: [String: Any]?, parameterEncoding: ParameterEncoding) throws -> URLRequest {
        do {
            return try parameterEncoding.encode(self, with: parameters)
        } catch {
            throw MoyaError.parameterEncoding(error)
        }
    }
}


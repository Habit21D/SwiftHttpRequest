
enum HttpCode : Int {
    case success = 1 //请求成功的状态吗
    case needLogin = -1  // 返回需要登录的错误码
}

struct BaseModel: Decodable {
    var code: Int
    var data: Content
    struct Content: Decodable {
        var message: String
    }
}


extension BaseModel {
    var generalCode: Int {
        return code
    }

    var generalMessage: String {
        return data.message
    }
}

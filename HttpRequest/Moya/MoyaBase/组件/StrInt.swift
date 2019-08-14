//  用于处理后台服务器同一个字段返回数据类型可变的情况

import Foundation
///跨类型解析方式
// 一个含有int，string的类，可用于解析后台返回类型不确定的字段。即：把int\string解析成TStrInt且解析后TStrInt的int和string都有值
//----- 使用时如果报未初始化的错误，而且找不到原因时，可以尝试先修复model以外的错误，也许这个错误就会消失。。。。 这是编译器提示错误的原因
struct StrInt: Codable {
    var int:Int {
        didSet {
            let stringValue = String(int)
            if  stringValue != string {
                string = stringValue
            }
        }
    }
    
    var string:String {
        didSet {
            if let intValue = Int(string), intValue != int {
                int = intValue
            }
        }
    }
    
    init(from decoder: Decoder) throws {
        let singleValueContainer = try decoder.singleValueContainer()
        
        if let stringValue = try? singleValueContainer.decode(String.self)
        {
            string = stringValue
            int = Int(stringValue) ?? 0
            
        } else if let intValue = try? singleValueContainer.decode(Int.self)
        {
            int = intValue
            string = String(intValue);
        } else
        {
            int = 0
            string = ""
        }
    }
}

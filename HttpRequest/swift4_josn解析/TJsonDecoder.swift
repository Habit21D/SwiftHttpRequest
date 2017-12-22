//
//  TJsonDecoder.swift
//  HttpRequest
//
//  Created by 易金 on 2017/12/14.
//  Copyright © 2017年 JIN. All rights reserved.
//

import Foundation
class BaseModel: Decodable {
    var state_code: Int? = nil
    var message: String? = nil
}

class ModelDic<T: Decodable>: BaseModel{
    var data:T? = nil
}

class ModelArray<T: Decodable>: BaseModel {
    var data:[T]? = nil
}


extension Data {
    /// json data 转模型 -- Dic
     //  data对应的数据类型为字典时使用
    func jsonDicToModel<T: Decodable>(_ type: T.Type) -> ModelDic<T>? {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(ModelDic<T>.self, from: self)
        } catch {
            print("解析失败\(self)")
            return nil
        }
    }
    
    /// jsondata 转模型 -- Array
     //  data对应的数据类型为数组时使用
    func jsonArrayToModel<T: Decodable>(_ type: T.Type) -> ModelArray<T>? {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(ModelArray<T>.self, from: self)
        } catch {
            print("解析失败\(self)")
            return nil
        }
    }
}

extension String {
    /// json字符串转模型 -- Dic
    //  data对应的数据类型为字典时使用
    func jsonStringDicToModel<T: Decodable>(_ type: T.Type) -> ModelDic<T>? {
        
        if let jsonData = self.data(using: .utf8) {
            return jsonData.jsonDicToModel(T.self)
        }
        print("解析失败\(self)")
        return nil
    }
    
    /// json字符串转模型 -- Array
    //  data对应的数据类型为数组时使用
    func jsonStringArrayToModel<T: Decodable>(_ type: T.Type) -> ModelArray<T>? {
        
        if let jsonData = self.data(using: .utf8) {
            return jsonData.jsonArrayToModel(T.self)
        }
        print("解析失败\(self)")
        return nil
    }
}

//
//  ViewModel.swift
//  HttpRequest
//
//  Created by apple on 2017/8/3.
//  Copyright © 2017年 JIN. All rights reserved.
//

import Foundation
import Moya
import HandyJSON
import SwiftyJSON
class TestModel_swift4: Decodable {
    var args : [String:Any]?
    var headers : Headers_swift4?
    var origin : String?
    var url : String?
    class Headers_swift4: Decodable {
        var Accept:String = ""
        var Accept_Encoding = ""
        var Accept_Language = ""
        var Connection = ""
        var Cookie = ""
        var Host = ""
        var User_Agent = ""
        
        
        //指定不对应的字段。 属性Accept_Encoding 对应服务器的Accept-Encoding
        private enum CodingKeys: String, CodingKey {
            case Accept
            case Accept_Encoding = "Accept-Encoding"
            case Accept_Language = "Accept-Language"
            case Connection
            case Cookie
            case Host
            case User_Agent = "User-Agent"
        }
        
    }

}



class ViewModel {
    //HandyJSON解析
    class func loadData(params : [String : Any]?,success : @escaping (Any?)->(), failture : @escaping (NSError?)->()) {
        let provider = RxMoyaProvider<MyAPI>()
        provider.request(.testGet) { result in
            switch result {
            case let .success(response):
                
                //HandyJSON  解析可以是字符串也可以是字典，所以在这里做一下转换
                if let testModel = TestModel.deserialize(from: JSON(response.data).dictionaryObject as NSDictionary?)
                {
                success(testModel)
                }
            case let .failure(error):
                failture(error as NSError)
            }
        }
    }
    
    //swift4解析
    class func loadData2(params : [String : Any]?,success : @escaping (Any?)->(), failture : @escaping (NSError?)->()) {
        let provider = RxMoyaProvider<MyAPI>()
        provider.request(.testGet) { result in
            switch result {
            case let .success(response):
                let jsonDecoder = JSONDecoder()
                let modelObject = try? jsonDecoder.decode(TestModel_swift4.self, from: response.data)
                
                success(modelObject)
            case let .failure(error):
                failture(error as NSError)
            }
        }
    }

}

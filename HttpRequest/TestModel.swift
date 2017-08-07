//
//  HomeModel.swift
//  HttpRequest
//
//  Created by JIN on 2017/6/23.
//  Copyright © 2017年 JIN. All rights reserved.
//  调用示例

import Foundation
import HandyJSON
//JSON转model ，使用了阿里巴巴出品的HandyJSON，类似于MJExtention
class TestModel: HandyJSON {
    var args : [String:Any]?
    var headers : Headers?
    var origin = ""
    var url = ""
    
    required init() {}
}

class Headers: HandyJSON {
    var Accept:String = ""
    var Accept_Encoding = ""
    var Accept_Language = ""
    var Connection = ""
    var Cookie = ""
    var Host = ""
    var User_Agent = ""
    required init() {}
    
    //指定不对应的字段。 属性Accept_Encoding 对应服务器的Accept-Encoding
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.Accept_Encoding <-- "Accept-Encoding"
        mapper <<<
            self.Accept_Language <-- "Accept-Language"
        mapper <<<
            self.User_Agent <-- "User-Agent"
    }
}


//测试网络的类
class TestNet {
    class func loadData(params : [String : Any]?,success : @escaping (Any?)->(), failture : @escaping (NSError)->()) {
        NetworkTools.POST(URLString:URL_Alamofire_test, params: params, success: { (result) in
            //JSON的String转model
            if let testModel = TestModel.deserialize(from:result)
            {//model处理后传出
                print(testModel);
                success(testModel)
            }
        }) { (error) in
            // 传出错误信息
            failture(error)
        }
    }
    
    
}


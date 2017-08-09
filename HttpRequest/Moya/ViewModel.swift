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
class ViewModel {
    
    class func loadData(params : [String : Any]?,success : @escaping (Any?)->(), failture : @escaping (NSError?)->()) {
        let provider = RxMoyaProvider<MyAPI>()
        provider.request(.testGet) { result in
            switch result {
            case let .success(response):
                
                //HandyJSON  解析道可以是字符串也可以是字典，所以在这里做一下转换
                if let testModel = TestModel.deserialize(from: JSON(response.data).dictionaryObject as NSDictionary?)
                {
                success(testModel)
                }
            case let .failure(error):
                failture(error as NSError)
            }
        }
    }

}

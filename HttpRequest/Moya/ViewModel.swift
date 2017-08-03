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
                
                if let testModel = TestModel.deserialize(from: JSON(response.data).dictionary as NSDictionary?)
                {
                success(testModel)
                }
            case let .failure(error):
                failture(error as NSError)
            }
        }
    }

}

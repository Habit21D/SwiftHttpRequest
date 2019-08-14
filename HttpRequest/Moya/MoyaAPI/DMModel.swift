//  rankList的model

import Foundation

struct DMModel: Codable {
    var code: StrInt
    var data: DMData
    
    struct DMData: Codable {
        var stateCode: StrInt
        var message: String
        var returnData: DMReturnData?
    }
    
    struct DMReturnData: Codable {
        var rankinglist: [DMRankingList]?
    }
    
    struct DMRankingList: Codable {
        var title: String
        var subTitle: String
        var cover: String
        var argName: String
        var argValue: StrInt
        var rankingType: String
    }
}


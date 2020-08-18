//  rankList的model

import Foundation

struct DMModel: Codable {
    var code: Int
    var data: DMData
    struct DMData: Codable {
        var stateCode: Int
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
        var argValue: Int
        var rankingType: String
    }
}


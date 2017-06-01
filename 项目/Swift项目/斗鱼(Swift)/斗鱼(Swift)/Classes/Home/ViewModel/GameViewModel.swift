//
//  GameViewModel.swift
//  斗鱼(Swift)
//
//  Created by 金亮齐 on 2017/5/31.
//  Copyright © 2017年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class GameViewModel: NSObject {
    lazy var games : [GameModel] = [GameModel]()
}



extension GameViewModel {
    func loadAllGameData(_ finishedCallback: @escaping () -> ()) {
        NetWorkTools.requestData1(.get, urlString:  "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) -> () in
            // 1.获取到数据
            guard let resultDict = result as? [String: Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String: Any]] else { return }
            
            // 2.字典转模型
            for dict in dataArray {
                self.games.append(GameModel(dict: dict))
            }
            
            // 3.完成回调
            finishedCallback()
        }
    }
}

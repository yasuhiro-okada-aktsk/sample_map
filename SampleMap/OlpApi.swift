//
//  LocalSearchApi.swift
//  SampleMap
//
//  Created by yasuhiro.okada on 2016/01/22.
//  Copyright © 2016年 yasuhiro.okada. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

/**
 * Yahoo! Open Local Platform
 */
class OlpApi {
    static func localSearch(callback: (Array<Feature>) -> ()) {
        Alamofire.request(.GET, "http://search.olp.yahooapis.jp/OpenLocalPlatform/V1/localSearch",
            parameters: [
                "appid" : "dj0zaiZpPXBoYkNKZWkwMjgyaSZzPWNvbnN1bWVyc2VjcmV0Jng9NTM-",
                "output" : "json",
                "query" : "観光地"
            ])
            .responseJSON { response in
                
                if let JSON = response.result.value {
                    let result : LocalSearchResponse = Mapper<LocalSearchResponse>().map(JSON)!
                    callback(result.features!)
                }
        }
    }
}

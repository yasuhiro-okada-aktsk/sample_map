//
//  LocalSearchResponse.swift
//  SampleMap
//
//  Created by yasuhiro.okada on 2016/01/22.
//  Copyright © 2016年 yasuhiro.okada. All rights reserved.
//

import Foundation
import ObjectMapper

class LocalSearchResponse: Mappable {
    var features: [Feature]?
    
    required init?(_ map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        features          <- map["Feature"]
    }
}

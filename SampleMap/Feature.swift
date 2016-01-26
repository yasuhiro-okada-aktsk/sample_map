//
//  Feature.swift
//  SampleMap
//
//  Created by yasuhiro.okada on 2016/01/22.
//  Copyright © 2016年 yasuhiro.okada. All rights reserved.
//

import Foundation
import CoreLocation
import ObjectMapper

class Feature: Mappable {
    var id: String?
    var name: String?
    var cordinates: CLLocationCoordinate2D?
    
    init() {
        
    }
    
    required init?(_ map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        id          <- map["Id"]
        name        <- map["Name"]
        cordinates  <- (map["Geometry.Coordinates"], CordTransform())
    }
}


class CordTransform : TransformType {
    typealias Object = CLLocationCoordinate2D
    typealias JSON = String
    
    func transformFromJSON(value: AnyObject?) -> CLLocationCoordinate2D? {
        let values = value!.componentsSeparatedByString(",")
        return CLLocationCoordinate2DMake(Double(values[1])!, Double(values[0])!)
    }
    
    func transformToJSON(value: CLLocationCoordinate2D?) -> String? {
        return nil
    }
    
}

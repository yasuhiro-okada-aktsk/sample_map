//
//  ListViewController.swift
//  SampleMap
//
//  Created by yasuhiro.okada on 2016/01/22.
//  Copyright © 2016年 yasuhiro.okada. All rights reserved.
//

import UIKit

class ListViewController : UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let filepath = NSBundle.mainBundle().pathForResource("assets/data", ofType: "js")
            let localFileUrl = NSURL(fileURLWithPath: filepath!)
            let contentOfLocalFile = NSData(contentsOfURL:localFileUrl)
            let object = try NSJSONSerialization.JSONObjectWithData(contentOfLocalFile!, options: .MutableContainers)
            print("data : \(object)")
            
        } catch {
            NSLog("error!")
        }
        
    }
}

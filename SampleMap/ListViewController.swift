//
//  ListViewController.swift
//  SampleMap
//
//  Created by yasuhiro.okada on 2016/01/22.
//  Copyright © 2016年 yasuhiro.okada. All rights reserved.
//

import UIKit

let reuseIdUser = "PoiCell"

class ListViewController : UICollectionViewController {
    private var adapter = ContentAdapter()
    
    private var poi: Dictionary<String, AnyObject>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView!.registerClass(PoiCell.self, forCellWithReuseIdentifier: reuseIdUser)

        let data = loadLocalData() as! [AnyObject]
        self.adapter.addData(ViewType.Poi, data: data)
        self.collectionView?.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch(segue.identifier!) {
        case "showMap":
            let controller : MapViewController = segue.destinationViewController as! MapViewController
            controller.poi = self.poi;
            
        default:
            NSLog("unknown segue \(segue.identifier)")
        }
    }
    
    func loadLocalData() -> AnyObject? {
        do {
            let filepath = NSBundle.mainBundle().pathForResource("assets/data", ofType: "js")
            let localFileUrl = NSURL(fileURLWithPath: filepath!)
            let contentOfLocalFile = NSData(contentsOfURL:localFileUrl)
            let object = try NSJSONSerialization.JSONObjectWithData(contentOfLocalFile!, options: .MutableContainers)
            return object
            
        } catch {
            NSLog("error!")
        }
        
        return nil
    }
}

extension ListViewController /*: UICollectionViewDataSource*/ {
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return adapter.sectionCount()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return adapter.spanCount(section)
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return adapter.createCell(collectionView, cellForItemAtIndexPath: indexPath)
    }
}

extension ListViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            let width = floorf(Float(collectionView.frame.size.width) / 2) - 6;
            let height = width;
            
            return CGSize(width: Int(width), height: Int(height))
    }
    
    /*
    func collectionView(collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAtIndex section: Int) -> UIEdgeInsets {
    return sectionInsets
    }
    */
}

extension ListViewController /*: UICollectionViewDelegate */ {
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.poi = self.adapter.getData(indexPath.section * 2 + indexPath.row) as? Dictionary<String, AnyObject>
        
        self.performSegueWithIdentifier("showMap", sender: self)
    }
}

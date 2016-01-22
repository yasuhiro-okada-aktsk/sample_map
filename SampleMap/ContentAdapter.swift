import Foundation
import UIKit

class ContentAdapter : BaseAdapter {
    override init() {
        super.init()
        addHandler(ViewType.Poi, handler: PoiHandler())
    }
    
    func createCell(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdUser, forIndexPath: indexPath) as! PoiCell
        
        let data = getData(indexPath.section * 2 + indexPath.row) as! Dictionary<String, AnyObject>
        cell.setContent(data)
        return cell
    }
}


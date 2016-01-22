import Foundation

class BaseAdapter {
    var viewTypes = [ViewType]()
    var data = [Any]()
    
    var handlers = [ViewType: BaseHandler]()
    
    var modified = true
    var spanCounts = [Int]()
    
    private func calcSpan() {
        if (!modified) {
            return
        }
        
        spanCounts.removeAll()
        spanCounts.append(0)
        var totalSpanSize : Float = 0;
        for (var i = 0; i < count(); ++i) {
            let spanSize = getHandler(i).getSpanSize()
            totalSpanSize += spanSize
            if (totalSpanSize > 1.0) {
                spanCounts.append(0)
                totalSpanSize = spanSize
            }
            
            ++spanCounts[spanCounts.count - 1]
        }
        
        modified = false
    }
    
    internal func addHandler(viewType: ViewType, handler: BaseHandler) {
        handlers[viewType] = handler
    }
    
    internal func getHandler(position: Int) -> BaseHandler {
        return handlers[getViewType(position)]!
    }
    
    func count() -> Int {
        return data.count
    }
    
    func sectionCount() -> Int {
        calcSpan()
        return spanCounts.count;
    }
    
    func spanCount(section: Int) -> Int {
        calcSpan()
        return spanCounts[section];
    }
    
    func getViewType(position: Int) -> ViewType {
        return viewTypes[position]
    }
    
    func getData(position: Int) -> Any {
        return data[position]
    }
    
    func addDatum(viewType: ViewType, datum: Any) {
        viewTypes.append(viewType)
        data.append(datum)
        
        modified = true
    }
    
    func addData(viewType: ViewType, data: [AnyObject]) {
        for datum in data {
            self.addDatum(viewType, datum: datum)
        }
    }
}
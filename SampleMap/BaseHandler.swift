import Foundation

class BaseHandler {
    let SPAN_RATIO_100 : Float = 1.0;
    let SPAN_RATIO_50 : Float = 1.0 / 2;
    let SPAN_RATIO_33 : Float = 1.0 / 3;
    let SPAN_RATIO_25 : Float = 1.0 / 4;
    
    func getSpanSize() -> Float {
        return SPAN_RATIO_100
    }
}

import Foundation
import Nimble
import SwiftyJSON

public func beJSON<T>() -> MatcherFunc<T> {
    return MatcherFunc { actualExpression, failureMessage in
        failureMessage.postfixMessage = "be JSON"
        if let str: String = try actualExpression.evaluate() as? String, let data: NSData = str.dataUsingEncoding(NSUTF8StringEncoding) {
            let json = JSON(data: data)
            return json.null == nil
        }
        return false
    }
}
import Foundation
import Nimble

public func beJSON<T>() -> MatcherFunc<T> {
    return MatcherFunc { actualExpression, failureMessage in
        failureMessage.postfixMessage = "be JSON"
        if let str: String = try actualExpression.evaluate() as? String, let data: NSData = str.dataUsingEncoding(NSUTF8StringEncoding) {
            if let _ = try? NSJSONSerialization.JSONObjectWithData(data, options: []) {
                return true
            }
        }
        return false
    }
}
import Foundation
import Nimble
import SwiftyJSON

public func beJSONAs<T>(expected: AnyObject) -> MatcherFunc<T> {
    return MatcherFunc { actualExpression, failureMessage in
        let expectedJSON = JSON(expected)
        if let str: String = try actualExpression.evaluate() as? String, let data: NSData = str.dataUsingEncoding(NSUTF8StringEncoding) {
            let json = JSON(data: data)
            return json == expectedJSON
        }
        return false
    }
}
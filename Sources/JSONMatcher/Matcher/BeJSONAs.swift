import Foundation
import Nimble

public func beJSONAs<T>(expected: AnyObject) -> MatcherFunc<T> {
    return MatcherFunc { actualExpression, failureMessage in
        return false
    }
}
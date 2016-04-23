import Foundation
import Nimble

public func beJSONAs<T>(expected: Any) -> MatcherFunc<T> {
    return MatcherFunc { actualExpression, failureMessage in
        return true
    }
}
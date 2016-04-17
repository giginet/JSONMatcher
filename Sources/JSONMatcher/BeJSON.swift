import Foundation

public func beJSON<T>() -> MatcherFunc<T> {
    return MatcherFunc { actualExpression, failureMessage in
        failureMessage.postfixMessage = "be nil"
        let actualValue = try actualExpression.evaluate()
        return actualValue == nil
    }
}
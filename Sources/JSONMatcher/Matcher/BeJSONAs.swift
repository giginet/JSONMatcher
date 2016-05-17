import Foundation
import Nimble

public func beJSONAs<T>(expected: AnyObject) -> MatcherFunc<T> {
    return MatcherFunc { actualExpression, failureMessage in
        let extractor = Extractor()
        let object = try! actualExpression.evaluate()
        let lhs = extractor.extract(object)
        let rhs = extractor.extract(expected)
        var comparer = Comparer()
        if let message = comparer.failureMessage {
            failureMessage.userDescription = message
        }
        return comparer.compare(lhs, rhs)
    }
}
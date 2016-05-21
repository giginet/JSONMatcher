import Foundation
import Nimble

public func beJSONIncluding<T>(expected: AnyObject) -> MatcherFunc<T> {
    return MatcherFunc { actualExpression, failureMessage in
        let extractor = Extractor()
        let object = try! actualExpression.evaluate()
        let lhs = extractor.extract(object)
        let rhs = extractor.extract(expected)
        let comparer = Comparer()
        failureMessage.postfixMessage = "include <\(stringify(rhs))>"
        return comparer.include(lhs, rhs)
    }
}

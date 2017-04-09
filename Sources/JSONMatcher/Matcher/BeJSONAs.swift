import Foundation
import Nimble

public func beJSONAs<T>(_ expected: Any) -> MatcherFunc<T> {
    return MatcherFunc { actualExpression, failureMessage in
        let extractor = Extractor()
        let object = try! actualExpression.evaluate()
        let lhs = extractor.extract(object)
        let rhs = extractor.extract(expected)
        let comparer = Comparer()
        failureMessage.postfixMessage = "equal to <\(stringify(rhs))>"
        return comparer.compare(lhs, rhs)
    }
}

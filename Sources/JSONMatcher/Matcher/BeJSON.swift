import Foundation
import Nimble

public func beJSON<T>() -> MatcherFunc<T> {
    return MatcherFunc { actualExpression, failureMessage in
        failureMessage.postfixMessage = "be JSON"
        let extractor = Extractor()
        return extractor.isValid(try! actualExpression.evaluate())
    }
}

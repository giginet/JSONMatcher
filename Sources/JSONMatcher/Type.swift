import Foundation

public enum Type {
    case Number
    case String
    case Boolean
    case Array
    case Dictionary
    case Null
    case Unknown
}

internal extension Type {
    func isKindOf(a: AcceptableValueType) -> Bool {
        return self == guessType(a)
    }
    
    private func guessType(value: AcceptableValueType) -> Type {
        switch value {
        case is NSNumber:
            return .Number
        case is Swift.String:
            return .String
        case is Bool:
            return .Boolean
        case is [JSONElement]:
            return .Array
        case is [Swift.String: JSONElement]:
            return .Dictionary
        case is NSNull, is ():
            return .Null
        default:
            return .Unknown
        }
    }
}
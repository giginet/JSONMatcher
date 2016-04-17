import Foundation

enum Type: Int {
    case Number
    case String
    case Bool
    case Array
    case Dictionary
    case Null
    case Unknown
}

struct Element<T> {
    private(set) var type: Type
    
    init(value: Any) {
        switch value  {
        case is String:
            self.type = .String
        default:
            self.type = .Unknown
        }
    }
}

func ==<T: Comparable>(lhs: Element<T>, rhs: Element<T>) -> Bool {
    return true
}
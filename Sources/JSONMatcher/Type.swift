import Foundation

public class Type: Equatable {
    enum RawType {
        case Number
        case String
        case Boolean
        case Array
        case Dictionary
        case Null
        case Unknown
    }

    let rawType: RawType

    init(_ rawType: RawType) {
        self.rawType = rawType
    }

    public static let Number = Type(RawType.Number)
    public static let String = Type(RawType.String)
    public static let Boolean = Type(RawType.Boolean)
    public static let Array = Type(RawType.Array)
    public static let Dictionary = Type(RawType.Dictionary)
    public static let Null = Type(RawType.Null)
}

public func == (lhs: Type, rhs: Type) -> Bool {
    return lhs.rawType == rhs.rawType
}

import Foundation

public class Type: Equatable {
    enum RawType {
        case number
        case string
        case boolean
        case array
        case dictionary
        case null
        case unknown
    }

    let rawType: RawType

    init(_ rawType: RawType) {
        self.rawType = rawType
    }

    public static let Number = Type(RawType.number)
    public static let String = Type(RawType.string)
    public static let Boolean = Type(RawType.boolean)
    public static let Array = Type(RawType.array)
    public static let Dictionary = Type(RawType.dictionary)
    public static let Null = Type(RawType.null)
}

public func == (lhs: Type, rhs: Type) -> Bool {
    return lhs.rawType == rhs.rawType
}

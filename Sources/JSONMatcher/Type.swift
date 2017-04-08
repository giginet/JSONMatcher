import Foundation

open class Type: Equatable {
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

    open static let Number = Type(RawType.number)
    open static let String = Type(RawType.string)
    open static let Boolean = Type(RawType.boolean)
    open static let Array = Type(RawType.array)
    open static let Dictionary = Type(RawType.dictionary)
    open static let Null = Type(RawType.null)
}

public func == (lhs: Type, rhs: Type) -> Bool {
    return lhs.rawType == rhs.rawType
}

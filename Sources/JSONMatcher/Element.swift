import Foundation

typealias ElementArray = [BaseElementType]
typealias ElementDictionary = [String: BaseElementType]

protocol BaseElementType { }

protocol ElementType: BaseElementType, CustomStringConvertible {
    associatedtype T
    var value: T { get }
    var type: Type.RawType { get }
}

extension ElementType {
    var description: String {
        return String(describing: self.value)
    }
}

struct NumberElement: ElementType {
    let value: NSNumber
    let type: Type.RawType = .number

    init(_ number: NSNumber) {
        self.value = number
    }

    init(_ number: Int) {
        self.value = NSNumber(value: number)
    }

    init(_ number: Double) {
        self.value = NSNumber(value: number)
    }
}

struct StringElement: ElementType {
    let value: String
    let type: Type.RawType = .string

    init(_ string: String) {
        self.value = string
    }

    var description: String {
        return "\"\(value)\""
    }
}

struct BooleanElement: ElementType {
    let value: Bool
    let type: Type.RawType = .boolean

    init(_ bool: Bool) {
        self.value = bool
    }
}

struct NullElement: ElementType {
    let value: NSNull
    let type: Type.RawType = .null

    init(_ null: NSNull) {
        self.value = null
    }

    init() {
        self.value = NSNull()
    }
}

struct ArrayElement: ElementType {
    let value: ElementArray
    let type: Type.RawType = .array

    init(_ array: ElementArray) {
        self.value = array
    }
}

struct DictionaryElement: ElementType {
    let value: ElementDictionary
    let type: Type.RawType = .dictionary

    init(_ dictionary: ElementDictionary) {
        self.value = dictionary
    }
}

struct RegexElement: ElementType {
    let value: NSRegularExpression
    let type: Type.RawType = .unknown

    init(_ regex: NSRegularExpression) {
        self.value = regex
    }
}

struct TypeElement: ElementType {
    let value: Type
    let type: Type.RawType = .unknown

    init(_ type: Type) {
        self.value = type
    }
}

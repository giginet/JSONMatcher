import Foundation

enum Type {
    case Number
    case String
    case Boolean
    case Array
    case Dictionary
    case Null
    case Unknown
}

public class JSONType {
    let type: Type
    
    init(_ type: Type) {
        self.type = type
    }
}

public let NumberType = JSONType(Type.Number)
public let StingType = JSONType(Type.String)
public let BooleanType = JSONType(Type.Boolean)
public let ArrayType = JSONType(Type.Array)
public let DictionaryType = JSONType(Type.Dictionary)
public let NullType = JSONType(Type.Null)

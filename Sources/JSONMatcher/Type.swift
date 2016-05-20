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

    public static let Number = JSONType(Type.Number)
    public static let String = JSONType(Type.String)
    public static let Boolean = JSONType(Type.Boolean)
    public static let Array = JSONType(Type.Array)
    public static let Dictionary = JSONType(Type.Dictionary)
    public static let Null = JSONType(Type.Null)
}

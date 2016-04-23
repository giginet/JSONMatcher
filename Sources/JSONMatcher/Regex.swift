import Foundation

public struct Regex {
    let pattern: String
    let options: NSRegularExpressionOptions!
    
    private var matcher: NSRegularExpression {
        return try! NSRegularExpression(pattern: self.pattern, options: self.options)
    }
    
    init(_ pattern: String, options: NSRegularExpressionOptions = []) {
        self.pattern = pattern
        self.options = options
    }
    
    func match(string: String) -> Bool {
        let matches = self.matcher.matchesInString(string, options:[], range:NSMakeRange(0, string.characters.count))
        return !matches.isEmpty
    }
}

extension Regex: StringLiteralConvertible {
    public typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    public typealias UnicodeScalarLiteralType = StringLiteralType
    
    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self.init("\(value)")
    }
    
    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self.init(value)
    }
    
    public init(stringLiteral value: StringLiteralType) {
        self.init(value)
    }
}
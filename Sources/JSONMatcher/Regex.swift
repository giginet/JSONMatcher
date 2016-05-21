import Foundation

public extension StringLiteralConvertible {
    var regex: NSRegularExpression {
        return try! NSRegularExpression(pattern: self as! String, options: [])
    }
}

internal extension NSRegularExpression {
    func match(string: String) -> Bool {
        let range = NSRange(location: 0, length: string.characters.count)
        let matches = self.matchesInString(string, options:[], range:range)
        return !matches.isEmpty
    }
}

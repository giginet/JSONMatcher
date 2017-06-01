import Foundation

public extension ExpressibleByStringLiteral {
    var regex: NSRegularExpression {
        return try! NSRegularExpression(pattern: self as! String, options: [])
    }
}

internal extension NSRegularExpression {
    func match(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.characters.count)
        let matches = self.matches(in: string, options:[], range:range)
        return !matches.isEmpty
    }
}

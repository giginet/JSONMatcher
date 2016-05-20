import Foundation

public class Regex {
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
        let range = NSRange(location: 0, length: string.characters.count)
        let matches = self.matcher.matchesInString(string, options:[], range:range)
        return !matches.isEmpty
    }
}

public extension StringLiteralConvertible {
    var regex: Regex {
        let regex = Regex(self as! String)
        return regex
    }
}

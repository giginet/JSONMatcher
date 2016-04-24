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
        let matches = self.matcher.matchesInString(string, options:[], range:NSMakeRange(0, string.characters.count))
        return !matches.isEmpty
    }
}

extension StringLiteralConvertible {
    func regex() -> JSONElement {
        let regex = Regex(self as! String)
        return JSONElement(regex)
    }
}
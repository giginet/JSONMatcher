import Foundation

public struct Regex {
    let pattern: NSRegularExpression
    
    init(_ pattern: String) {
        self.pattern = try! NSRegularExpression(pattern: pattern, options: [])
    }
    
    func match(string: String) -> Bool {
        let matches = self.pattern.matchesInString(string, options:[], range:NSMakeRange(0, string.characters.count))
        return !matches.isEmpty
    }
}
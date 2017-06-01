import Foundation
import XCTest

class BaseTestCase: XCTestCase {
    func loadJSONFile(_ jsonName: String) -> String {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: jsonName, ofType: "json")!
        let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path))
        return String(data: jsonData!, encoding: .utf8)!
    }
}

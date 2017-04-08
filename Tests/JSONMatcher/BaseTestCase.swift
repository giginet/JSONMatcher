import Foundation
import XCTest

class BaseTestCase: XCTestCase {
    func loadJSONFile(_ JSONName: String) -> String {
        let bundle = Bundle(for: self.dynamicType)
        let path = bundle.path(forResource: JSONName, ofType: "json")!
        let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path))
        return String(data: jsonData!, encoding: String.Encoding.utf8)!
    }
}

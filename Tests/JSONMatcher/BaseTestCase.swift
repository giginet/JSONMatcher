import Foundation
import XCTest

class BaseTestCase: XCTestCase {
    func loadJSONFile(_ JSONName: String) -> String {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: JSONName, ofType: "json")!
        let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path))
        return String(data: jsonData!, encoding: .utf8)!
    }
}

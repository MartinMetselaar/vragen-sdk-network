import XCTest
import Moya

extension XCTestCase {
    func assert<E: Error>(_ result: Result<Any, E>?, contains expectedError: Error, in file: StaticString = #file, line: UInt = #line) {
        switch result {
            case .success:
                XCTFail("No error thrown", file: file, line: line)
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, expectedError.localizedDescription, file: file, line: line)
            case nil:
                XCTFail("Result was nil", file: file, line: line)
        }
    }

    func assert<T: Equatable, E: Error>(_ result: Result<T, E>?, contains exceptedObject: T, in file: StaticString = #file, line: UInt = #line) {
        switch result {
            case .success(let object):
                XCTAssertEqual(object, exceptedObject, file: file, line: line)
            case .failure(let error):
                XCTFail("An error was thrown: \(error)", file: file, line: line)
            case nil:
                XCTFail("Result was nil", file: file, line: line)
        }
    }
}

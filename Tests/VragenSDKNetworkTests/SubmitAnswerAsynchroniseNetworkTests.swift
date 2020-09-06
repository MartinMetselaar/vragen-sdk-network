import XCTest
@testable import VragenSDKNetwork
import VragenAPIModels
import Moya

final class SubmitAnswerAsynchroniseNetworkTests: XCTestCase {

    var sut: SubmitAnswerAsynchroniseNetwork!

    // MARK: - Submit

    func test_submit() {
        // Given
        sut = SubmitAnswerAsynchroniseNetwork(fileName: post_api_v1_submit_200)
        
        // When
        let expectation = XCTestExpectation(description: "Submitting answer")

        var sutResult: Result<SubmitAnswerResponse, MoyaError>? = nil
        sut.submit(userId: "", surveyId: UUID(), questionId: UUID(), answerId: UUID()) { (result) in
            sutResult = result
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        // Then
        let expected = SubmitAnswerResponse(
            userId: "789",
            surveyId: UUID(uuidString: "2D55F5E2-F8E1-421E-8BCA-DB3E4EE94858")!,
            questionId: UUID(uuidString: "96C05D2F-BE8D-4E93-8B14-E5485E86E9BB")!,
            answerId: UUID(uuidString: "AF47DAC9-5543-4C89-8116-627DABA1BF22")!
        )
        assert(sutResult, contains: expected)
    }
}

extension SubmitAnswerAsynchroniseNetwork {

    convenience init(statusCode: Int = 200, fileName: String) {
        #if swift(>=5.3)
            #warning("Should be converted to json files in a /Resources folder")
        #endif

        let data = fileName.data(using: .utf8) ?? Data()
        self.init(response: .networkResponse(statusCode, data))
    }

    convenience init(response: EndpointSampleResponse) {
        self.init(provider: MoyaProvider<SubmitAnswerService>(response: response))
    }
}

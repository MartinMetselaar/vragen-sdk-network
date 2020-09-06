import XCTest
@testable import VragenSDKNetwork
import VragenAPIModels
import Moya

final class SubmitAnswerSynchroniseNetworkTests: XCTestCase {

    var sut: SubmitAnswerSynchroniseNetwork!

    // MARK: - Submit

    func test_submit() {
        // Given
        sut = SubmitAnswerSynchroniseNetwork(fileName: post_api_v1_submit_200)

        // When
        let result = sut.submit(userId: "", surveyId: UUID(), questionId: UUID(), answerId: UUID())

        // Then
        let expected = SubmitAnswerResponse(
            userId: "789",
            surveyId: UUID(uuidString: "2D55F5E2-F8E1-421E-8BCA-DB3E4EE94858")!,
            questionId: UUID(uuidString: "96C05D2F-BE8D-4E93-8B14-E5485E86E9BB")!,
            answerId: UUID(uuidString: "AF47DAC9-5543-4C89-8116-627DABA1BF22")!
        )
        assert(result, contains: expected)
    }
}

extension SubmitAnswerSynchroniseNetwork {

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

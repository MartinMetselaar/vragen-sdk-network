import XCTest
@testable import VragenSDKNetwork
import VragenAPIModels
import Moya

final class SurveyAsynchroniseNetworkTests: XCTestCase {

    var sut: SurveyAsynchroniseNetwork!

    // MARK: - Get with children

    func test_getWithChildren() {
        // Given
        sut = SurveyAsynchroniseNetwork(fileName: get_api_v1_surveys_identifier_children_200)

        // When
        let expectation = XCTestExpectation(description: "Retrieving survey")

        var sutResult: Result<SurveyWithQuestionsResponse, MoyaError>? = nil
        sut.getWithChildren(identifier: UUID()) { (result) in
            sutResult = result
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        // Then
        let expected = SurveyWithQuestionsResponse(
            id: UUID(uuidString: "2B2A8838-9C35-4672-B873-5CD58B39395C")!,
            title: "This is a survey with children",
            questions: [
                QuestionWithAnswersResponse(
                    id: UUID(uuidString: "F4DC0B2B-3480-4FFD-9952-6BBE136A9A67")!,
                    title: "Question 1",
                    answers: [
                        AnswerResponse(id: UUID(uuidString: "55393905-E1E0-40F3-9D26-740F9BAE44F4")!, title: "Answer 1"),
                        AnswerResponse(id: UUID(uuidString: "BCAB7533-86C0-424D-ABA0-7968A90F246B")!, title: "Answer 2"),
                ]),
            ]
        )
        assert(sutResult, contains: expected)
    }
}

extension SurveyAsynchroniseNetwork {

    convenience init(statusCode: Int = 200, fileName: String) {
        #if swift(>=5.3)
            #warning("Should be converted to json files in a /Resources folder")
        #endif

        let data = fileName.data(using: .utf8) ?? Data()
        self.init(response: .networkResponse(statusCode, data))
    }

    convenience init(response: EndpointSampleResponse) {
        self.init(provider: MoyaProvider<SurveyService>(response: response))
    }
}

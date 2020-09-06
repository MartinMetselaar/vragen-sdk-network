import XCTest
@testable import VragenSDKNetwork
import VragenAPIModels
import Moya

final class AnswerSynchroniseNetworkTests: XCTestCase {

    var sut: AnswerSynchroniseNetwork!

    // MARK: - List

    func test_list() {
        // Given
        sut = AnswerSynchroniseNetwork(fileName: get_api_v1_surveys_identifier_questions_identifier_answers_200)

        // When
        let result = sut.list(surveyId: UUID(), questionId: UUID(), page: 0, per: 0)

        // Then
        let expected = [
            AnswerResponse(id: UUID(uuidString: "2B2A8838-9C35-4672-B873-5CD58B39395C")!, title: "This is an answer")
        ]
        switch result {
            case .success(let page):
                XCTAssertEqual(page.items, expected)
            case .failure(let error):
                XCTFail("An error was thrown: \(error)")
        }
    }

    // MARK: - Create

    func test_create() {
        // Given
        sut = AnswerSynchroniseNetwork(fileName: post_api_v1_surveys_identifier_questions_identifier_answers_200)

        // When
        let result = sut.create(surveyId: UUID(), questionId: UUID(), title: "")

        // Then
        let expected = AnswerResponse(id: UUID(uuidString: "2B2A8838-9C35-4672-B873-5CD58B39395C")!, title: "Created answer")
        assert(result, contains: expected)
    }

    // MARK: - Get

    func test_get() {
        // Given
        sut = AnswerSynchroniseNetwork(fileName: get_api_v1_surveys_identifier_questions_identifier_answers_identifier_200)

        // When
        let result = sut.get(surveyId: UUID(), questionId: UUID(), identifier: UUID())

        // Then
        let expected = AnswerResponse(id: UUID(uuidString: "2B2A8838-9C35-4672-B873-5CD58B39395C")!, title: "Get answer")
        assert(result, contains: expected)
    }

    // MARK: - Update

    func test_update() {
        // Given
        sut = AnswerSynchroniseNetwork(fileName: post_api_v1_surveys_identifier_questions_identifier_answers_identifier_200)

        // When
        let result = sut.update(surveyId: UUID(), questionId: UUID(), identifier: UUID(), title: "")

        // Then
        let expected = AnswerResponse(id: UUID(uuidString: "2B2A8838-9C35-4672-B873-5CD58B39395C")!, title: "Updated answer")
        assert(result, contains: expected)
    }

    // MARK: - Delete

    func test_delete() {
        // Given
        sut = AnswerSynchroniseNetwork(fileName: delete_api_v1_surveys_identifier_questions_identifier_answers_identifier_200)

        // When
        let result = sut.delete(surveyId: UUID(), questionId: UUID(), identifier: UUID())

        // Then
        assert(result, contains: EmptyResponse())
    }
}

extension AnswerSynchroniseNetwork {

    convenience init(statusCode: Int = 200, fileName: String) {
        #if swift(>=5.3)
            #warning("Should be converted to json files in a /Resources folder")
        #endif

        let data = fileName.data(using: .utf8) ?? Data()
        self.init(response: .networkResponse(statusCode, data))
    }

    convenience init(response: EndpointSampleResponse) {
        self.init(provider: MoyaProvider<AnswerService>(response: response))
    }
}

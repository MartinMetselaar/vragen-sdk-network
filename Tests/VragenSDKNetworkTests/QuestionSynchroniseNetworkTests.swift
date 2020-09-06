import XCTest
@testable import VragenSDKNetwork
import VragenAPIModels
import Moya

final class QuestionSynchroniseNetworkTests: XCTestCase {

    var sut: QuestionSynchroniseNetwork!

    // MARK: - List

    func test_list() {
        // Given
        sut = QuestionSynchroniseNetwork(fileName: get_api_v1_surveys_identifier_questions_200)

        // When
        let result = sut.list(surveyId: "", page: 0, per: 0)

        // Then
        let expected = [
            QuestionResponse(id: "2B2A8838-9C35-4672-B873-5CD58B39395C", title: "This is a question")
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
        sut = QuestionSynchroniseNetwork(fileName: post_api_v1_surveys_identifier_questions_200)

        // When
        let result = sut.create(surveyId: "", title: "")

        // Then
        let expected = QuestionResponse(id: "2B2A8838-9C35-4672-B873-5CD58B39395C", title: "Created question")
        assert(result, contains: expected)
    }

    // MARK: - Get

    func test_get() {
        // Given
        sut = QuestionSynchroniseNetwork(fileName: get_api_v1_surveys_identifier_questions_identifier_200)

        // When
        let result = sut.get(surveyId: "", identifier: "")

        // Then
        let expected = QuestionResponse(id: "2B2A8838-9C35-4672-B873-5CD58B39395C", title: "Get question")
        assert(result, contains: expected)
    }

    // MARK: - Update

    func test_update() {
        // Given
        sut = QuestionSynchroniseNetwork(fileName: post_api_v1_surveys_identifier_questions_identifier_200)

        // When
        let result = sut.update(surveyId: "", identifier: "", title: "")

        // Then
        let expected = QuestionResponse(id: "2B2A8838-9C35-4672-B873-5CD58B39395C", title: "Updated question")
        assert(result, contains: expected)
    }

    // MARK: - Delete

    func test_delete() {
        // Given
        sut = QuestionSynchroniseNetwork(fileName: delete_api_v1_surveys_identifier_questions_identifier_200)

        // When
        let result = sut.delete(surveyId: "", identifier: "")

        // Then
        assert(result, contains: EmptyResponse())
    }
}

extension QuestionSynchroniseNetwork {

    convenience init(statusCode: Int = 200, fileName: String) {
        #if swift(>=5.3)
            #warning("Should be converted to json files in a /Resources folder")
        #endif

        let data = fileName.data(using: .utf8) ?? Data()
        self.init(response: .networkResponse(statusCode, data))
    }

    convenience init(response: EndpointSampleResponse) {
        self.init(provider: MoyaProvider<QuestionService>(response: response))
    }
}

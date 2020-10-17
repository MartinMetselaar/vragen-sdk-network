import XCTest
@testable import VragenSDKNetwork
import VragenAPIModels
import Moya

final class SurveySynchroniseNetworkTests: XCTestCase {

    var sut: SurveySynchroniseNetwork!

    // MARK: - List

    func test_list() {
        // Given
        sut = SurveySynchroniseNetwork(fileName: get_api_v1_surveys_200)

        // When
        let result = sut.list(page: 0, per: 0)

        // Then
        let expected = [
            SurveyResponse(id: UUID(uuidString: "2B2A8838-9C35-4672-B873-5CD58B39395C")!, title: "This is a survey"),
            SurveyResponse(id: UUID(uuidString: "8007F5B7-592A-4F59-9C44-0694CCA46386")!, title: "And another survey"),
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
        sut = SurveySynchroniseNetwork(fileName: post_api_v1_surveys_200)

        // When
        let result = sut.create(title: "")

        // Then
        let expected = SurveyResponse(id: UUID(uuidString: "2B2A8838-9C35-4672-B873-5CD58B39395C")!, title: "Created survey")
        assert(result, contains: expected)
    }

    // MARK: - Get

    func test_get() {
        // Given
        sut = SurveySynchroniseNetwork(fileName: get_api_v1_surveys_identifier_200)

        // When
        let result = sut.get(identifier: UUID())

        // Then
        let expected = SurveyResponse(id: UUID(uuidString: "2B2A8838-9C35-4672-B873-5CD58B39395C")!, title: "Get survey")
        assert(result, contains: expected)
    }

    // MARK: - Get with children

    func test_getWithChildren() {
        // Given
        sut = SurveySynchroniseNetwork(fileName: get_api_v1_surveys_identifier_children_200)

        // When
        let result = sut.getWithChildren(identifier: UUID())

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
        assert(result, contains: expected)
    }

    // MARK: - Update

    func test_update() {
        // Given
        sut = SurveySynchroniseNetwork(fileName: post_api_v1_surveys_identifier_200)

        // When
        let result = sut.update(identifier: UUID(), title: "")

        // Then
        let expected = SurveyResponse(id: UUID(uuidString: "2B2A8838-9C35-4672-B873-5CD58B39395C")!, title: "Updated survey")
        assert(result, contains: expected)
    }

    // MARK: - Delete

    func test_delete() {
        // Given
        sut = SurveySynchroniseNetwork(fileName: delete_api_v1_surveys_identifier_200)

        // When
        let result = sut.delete(identifier: UUID())

        // Then
        assert(result, contains: EmptyResponse())
    }

    // MARK: - Results

    func test_results() {
        // Given
        sut = SurveySynchroniseNetwork(fileName: get_api_v1_surveys_identifier_results_200)

        // When
        let result = sut.results(identifier: UUID())

        // Then
        switch result {
            case .success(let value):
                XCTAssertEqual(value, "userId,question,answer\nuser-id-123,Question 1,Answer 1\n")
            case .failure(let error):
                XCTFail("An error was thrown: \(error)")
        }
    }
}

extension SurveySynchroniseNetwork {

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

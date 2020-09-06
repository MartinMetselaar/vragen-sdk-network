import Foundation
import Moya
import VragenAPIModels

protocol QuestionNetworkable {

    /// Paginated list of questions.
    /// - Parameters:
    ///     - surveyId: id of the survey
    ///     - page: page index which starts at 1
    ///     - per: number of items per page
    func list(surveyId: UUID, page: Int?, per: Int?) -> Result<Page<QuestionResponse>, MoyaError>

    /// Create a new question.
    /// - Parameters:
    ///     - surveyId: id of the survey
    ///     - title: title of the question
    func create(surveyId: UUID, title: String) -> Result<QuestionResponse, MoyaError>

    /// Get a question.
    /// - Parameters:
    ///     - surveyId: id of the survey
    ///     - identifier: id of the question
    func get(surveyId: UUID, identifier: UUID) -> Result<QuestionResponse, MoyaError>

    /// Update a question.
    /// - Parameters:
    ///   - surveyId: id of the survey
    ///   - identifier: id of the question
    ///   - title: new title of the question
    func update(surveyId: UUID, identifier: UUID, title: String) -> Result<QuestionResponse, MoyaError>

    /// Delete a question.
    /// - Parameters:
    ///     - surveyId: id of the survey
    ///     - identifier: id of the question
    /// - Returns: when successful it returns an empty Data response
    func delete(surveyId: UUID, identifier: UUID) -> Result<EmptyResponse, MoyaError>
}

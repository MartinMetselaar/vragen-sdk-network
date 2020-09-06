import Foundation
import Moya
import VragenAPIModels

protocol AnswerNetworkable {

    /// Paginated list of answers.
    /// - Parameters:
    ///     - surveyId: id of the survey
    ///     - questionId: id of the question
    ///     - page: page index which starts at 1
    ///     - per: number of items per page
    func list(surveyId: UUID, questionId: UUID, page: Int?, per: Int?) -> Result<Page<AnswerResponse>, MoyaError>

    /// Create a new answer.
    /// - Parameters:
    ///     - surveyId: id of the survey
    ///     - questionId: id of the question
    ///     - title: title of the answer
    func create(surveyId: UUID, questionId: UUID, title: String) -> Result<AnswerResponse, MoyaError>

    /// Get a question.
    /// - Parameters:
    ///     - surveyId: id of the survey
    ///     - questionId: id of the question
    ///     - identifier: id of the answer
    func get(surveyId: UUID, questionId: UUID, identifier: UUID) -> Result<AnswerResponse, MoyaError>

    /// Update a question.
    /// - Parameters:
    ///   - surveyId: id of the survey
    ///   - questionId: id of the question
    ///   - identifier: id of the answer
    ///   - title: new title of the answer
    func update(surveyId: UUID, questionId: UUID, identifier: UUID, title: String) -> Result<AnswerResponse, MoyaError>

    /// Delete a question.
    /// - Parameters:
    ///     - surveyId: id of the survey
    ///     - questionId: id of the question
    ///     - identifier: id of the answer
    /// - Returns: when successful it returns an empty Data response
    func delete(surveyId: UUID, questionId: UUID, identifier: UUID) -> Result<EmptyResponse, MoyaError>
}

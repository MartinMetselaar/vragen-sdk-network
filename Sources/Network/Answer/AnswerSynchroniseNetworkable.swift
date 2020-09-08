import Foundation
import Moya
import VragenAPIModels

/// See `AnswerService` for documentation about the different endpoints.
public protocol AnswerSynchroniseNetworkable {

    /// Paginated list of answers.
    func list(surveyId: UUID, questionId: UUID, page: Int?, per: Int?) -> Result<Page<AnswerResponse>, MoyaError>

    /// Create a new answer.
    func create(surveyId: UUID, questionId: UUID, title: String) -> Result<AnswerResponse, MoyaError>

    /// Get a question.
    func get(surveyId: UUID, questionId: UUID, identifier: UUID) -> Result<AnswerResponse, MoyaError>

    /// Update a question.
    func update(surveyId: UUID, questionId: UUID, identifier: UUID, title: String) -> Result<AnswerResponse, MoyaError>

    /// Delete a question.
    /// - Returns: when successful it returns an empty Data response
    func delete(surveyId: UUID, questionId: UUID, identifier: UUID) -> Result<EmptyResponse, MoyaError>
}

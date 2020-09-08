import Foundation
import Moya
import VragenAPIModels

/// See `QuestionService` for documentation about the different endpoints.
public protocol QuestionSynchroniseNetworkable {

    /// Paginated list of questions.
    func list(surveyId: UUID, page: Int?, per: Int?) -> Result<Page<QuestionResponse>, MoyaError>

    /// Create a new question.
    func create(surveyId: UUID, title: String) -> Result<QuestionResponse, MoyaError>

    /// Get a question.
    func get(surveyId: UUID, identifier: UUID) -> Result<QuestionResponse, MoyaError>

    /// Update a question.
    func update(surveyId: UUID, identifier: UUID, title: String) -> Result<QuestionResponse, MoyaError>

    /// Delete a question.
    /// - Returns: when successful it returns an empty Data response
    func delete(surveyId: UUID, identifier: UUID) -> Result<EmptyResponse, MoyaError>
}

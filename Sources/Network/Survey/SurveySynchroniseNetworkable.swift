import Foundation
import Moya
import VragenAPIModels

/// See `SurveyService` for documentation about the different endpoints.
public protocol SurveySynchroniseNetworkable {

    /// Paginated list of surveys.
    func list(page: Int?, per: Int?) -> Result<Page<SurveyResponse>, MoyaError>

    /// Create a new survey.
    func create(title: String) -> Result<SurveyResponse, MoyaError>

    /// Get a survey.
    func get(identifier: UUID) -> Result<SurveyResponse, MoyaError>

    /// Get a survey which will include all its children (questions and possible answers).
    func getWithChildren(identifier: UUID) -> Result<SurveyWithQuestionsResponse, MoyaError>

    /// Update a survey.
    func update(identifier: UUID, title: String) -> Result<SurveyResponse, MoyaError>

    /// Delete a survey.
    /// - Returns: when successful it returns an empty Data response
    func delete(identifier: UUID) -> Result<EmptyResponse, MoyaError>
}

import Foundation
import Moya
import VragenAPIModels

protocol SurveyNetworkable {

    /// Paginated list of surveys.
    /// - Parameters:
    ///     - page: page index which starts at 1
    ///     - per: number of items per page
    func list(page: Int?, per: Int?) -> Result<Page<SurveyResponse>, MoyaError>

    /// Create a new survey.
    /// - Parameter title: title of the survey
    func create(title: String) -> Result<SurveyResponse, MoyaError>

    /// Get a survey.
    /// - Parameter identifier: id of the survey
    func get(identifier: UUID) -> Result<SurveyResponse, MoyaError>

    /// Get a survey which will include all its children (questions and possible answers).
    /// - Parameter identifier: id of the survey
    func getWithChildren(identifier: UUID) -> Result<SurveyWithQuestionsResponse, MoyaError>

    /// Update a survey.
    /// - Parameters:
    ///     - identifier: id of the survey
    ///     - title: new title of the survey
    func update(identifier: UUID, title: String) -> Result<SurveyResponse, MoyaError>

    /// Delete a survey.
    /// - Parameter identifier: id of the survey
    /// - Returns: when successful it returns an empty Data response
    func delete(identifier: UUID) -> Result<EmptyResponse, MoyaError>
}

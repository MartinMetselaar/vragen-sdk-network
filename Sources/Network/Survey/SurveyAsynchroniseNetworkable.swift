import Foundation
import Moya
import VragenAPIModels

/// See `SurveyService` for documentation about the different endpoints.
public protocol SurveyAsynchroniseNetworkable {
    
    /// Get a survey which will include all its children (questions and possible answers).
    func getWithChildren(identifier: UUID, completion: @escaping (_ result: Result<SurveyWithQuestionsResponse, MoyaError>) -> Void)
}

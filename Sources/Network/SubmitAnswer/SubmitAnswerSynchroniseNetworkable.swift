import Foundation
import Moya
import VragenAPIModels

/// See `SubmitAnswerService` for documentation about the different endpoints.
protocol SubmitAnswerSynchroniseNetworkable {

    /// Submit an answer on a question.
    func submit(userId: String, surveyId: UUID, questionId: UUID, answerId: UUID) -> Result<SubmitAnswerResponse, MoyaError>
}

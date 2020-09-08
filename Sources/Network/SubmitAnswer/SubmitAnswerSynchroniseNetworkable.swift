import Foundation
import Moya
import VragenAPIModels

/// See `SubmitAnswerService` for documentation about the different endpoints.
public protocol SubmitAnswerSynchroniseNetworkable {

    /// Submit an answer on a question.
    /// - NOTE: The user id is used to create a unique constraint on an answer. So if the user submits another answer on the same question it is updated.
    func submit(userId: String, surveyId: UUID, questionId: UUID, answerId: UUID) -> Result<SubmitAnswerResponse, MoyaError>
}

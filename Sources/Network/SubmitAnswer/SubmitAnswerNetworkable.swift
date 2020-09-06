import Foundation
import Moya
import VragenAPIModels

protocol SubmitAnswerNetworkable {

    /// Submit an answer on a question.
    /// - Parameters:
    ///   - userId: id of the user which is used to create a unique constraint on an answer. So if the user submits another answer on the same question it is updated. 
    ///   - surveyId: id of the survey
    ///   - questionId: id of the question
    ///   - answerId: id of the chosen answer
    func submit(userId: String, surveyId: UUID, questionId: UUID, answerId: UUID) -> Result<SubmitAnswerResponse, MoyaError>
}

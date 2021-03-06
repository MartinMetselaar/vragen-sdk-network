import Foundation
import Moya
import VragenAPIModels

/// See `SubmitAnswerService` for documentation about the different endpoints.
public class SubmitAnswerSynchroniseNetwork: SubmitAnswerSynchroniseNetworkable {
    public let provider: MoyaProvider<SubmitAnswerService>

    public convenience init(server: URL, token: String) {
        self.init(provider: VragenProvider<SubmitAnswerService>(server: server, token: token))
    }

    internal init(provider: MoyaProvider<SubmitAnswerService>) {
        self.provider = provider
    }

    public func submit(userId: String, surveyId: UUID, questionId: UUID, answerId: UUID) -> Result<SubmitAnswerResponse, MoyaError> {
        let input = SubmitAnswerRequest(userId: userId, surveyId: surveyId, questionId: questionId, answerId: answerId)
        return provider.request(.submit(input: input), to: SubmitAnswerResponse.self)
    }
}

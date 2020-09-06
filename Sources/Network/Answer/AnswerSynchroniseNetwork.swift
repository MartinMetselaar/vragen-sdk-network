import Foundation
import Moya
import VragenAPIModels

/// See `AnswerNetworkable` for documentation about the different endpoints.
public class AnswerSynchroniseNetwork: AnswerNetworkable {
    public let provider: MoyaProvider<AnswerService>

    public convenience init(server: URL, token: String) {
        self.init(provider: VragenProvider<AnswerService>(server: server, token: token))
    }

    internal init(provider: MoyaProvider<AnswerService>) {
        self.provider = provider
    }

    public func list(surveyId: UUID, questionId: UUID, page: Int?, per: Int?) -> Result<Page<AnswerResponse>, MoyaError> {
        return provider.request(.list(surveyId: surveyId, questionId: questionId, page: page, per: per), to: Page<AnswerResponse>.self)
    }

    public func create(surveyId: UUID, questionId: UUID, title: String) -> Result<AnswerResponse, MoyaError> {
        let input = QuestionCreateRequest(title: title)
        return provider.request(.create(surveyId: surveyId, questionId: questionId, input: input), to: AnswerResponse.self)
    }

    public func get(surveyId: UUID, questionId: UUID, identifier: UUID) -> Result<AnswerResponse, MoyaError> {
        return provider.request(.get(surveyId: surveyId, questionId: questionId, identifier: identifier), to: AnswerResponse.self)
    }

    public func update(surveyId: UUID, questionId: UUID, identifier: UUID, title: String) -> Result<AnswerResponse, MoyaError> {
        let input = QuestionCreateRequest(title: title)
        return provider.request(.update(surveyId: surveyId, questionId: questionId, identifier: identifier, input: input), to: AnswerResponse.self)
    }

    public func delete(surveyId: UUID, questionId: UUID, identifier: UUID) -> Result<EmptyResponse, MoyaError> {
        return provider.request(.delete(surveyId: surveyId, questionId: questionId, identifier: identifier), to: EmptyResponse.self)
    }
}

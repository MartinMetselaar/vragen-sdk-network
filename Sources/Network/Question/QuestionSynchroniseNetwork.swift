import Foundation
import Moya
import VragenAPIModels

/// See `QuestionNetworkable` for documentation about the different endpoints.
public class QuestionSynchroniseNetwork: QuestionNetworkable {
    public let provider: MoyaProvider<QuestionService>

    public convenience init(server: URL, token: String) {
        self.init(provider: VragenProvider<QuestionService>(server: server, token: token))
    }

    internal init(provider: MoyaProvider<QuestionService>) {
        self.provider = provider
    }

    public func list(surveyId: UUID, page: Int?, per: Int?) -> Result<Page<QuestionResponse>, MoyaError> {
        return provider.request(.list(surveyId: surveyId, page: page, per: per), to: Page<QuestionResponse>.self)
    }

    public func create(surveyId: UUID, title: String) -> Result<QuestionResponse, MoyaError> {
        let input = QuestionCreateRequest(title: title)
        return provider.request(.create(surveyId: surveyId, input: input), to: QuestionResponse.self)
    }

    public func get(surveyId: UUID, identifier: UUID) -> Result<QuestionResponse, MoyaError> {
        return provider.request(.get(surveyId: surveyId, identifier: identifier), to: QuestionResponse.self)
    }

    public func update(surveyId: UUID, identifier: UUID, title: String) -> Result<QuestionResponse, MoyaError> {
        let input = QuestionCreateRequest(title: title)
        return provider.request(.update(surveyId: surveyId, identifier: identifier, input: input), to: QuestionResponse.self)
    }

    public func delete(surveyId: UUID, identifier: UUID) -> Result<EmptyResponse, MoyaError> {
        return provider.request(.delete(surveyId: surveyId, identifier: identifier), to: EmptyResponse.self)
    }
}

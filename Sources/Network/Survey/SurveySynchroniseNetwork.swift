import Foundation
import Moya
import VragenAPIModels

/// See `SurveyNetworkable` for documentation about the different endpoints.
public class SurveySynchroniseNetwork: SurveyNetworkable {
    private let provider: MoyaProvider<SurveyService>

    public convenience init(server: URL, token: String) {
        self.init(provider: VragenProvider<SurveyService>(server: server, token: token))
    }

    internal init(provider: MoyaProvider<SurveyService>) {
        self.provider = provider
    }

    public func list(page: Int?, per: Int?) -> Result<Page<SurveyResponse>, MoyaError> {
        return provider.request(.list(page: page, per: per), to: Page<SurveyResponse>.self)
    }

    public func create(title: String) -> Result<SurveyResponse, MoyaError> {
        let input = SurveyCreateRequest(title: title)
        return provider.request(.create(input: input), to: SurveyResponse.self)
    }

    public func get(identifier: String) -> Result<SurveyResponse, MoyaError> {
        return provider.request(.get(identifier: identifier), to: SurveyResponse.self)
    }

    public func getWithChildren(identifier: String) -> Result<SurveyWithQuestionsResponse, MoyaError> {
        return provider.request(.getWithChildren(identifier: identifier), to: SurveyWithQuestionsResponse.self)
    }

    public func update(identifier: String, title: String) -> Result<SurveyResponse, MoyaError> {
        let input = SurveyCreateRequest(title: title)
        return provider.request(.update(identifier: identifier, input: input), to: SurveyResponse.self)
    }

    public func delete(identifier: String) -> Result<EmptyResponse, MoyaError> {
        return provider.request(.delete(identifier: identifier), to: EmptyResponse.self)
    }
}

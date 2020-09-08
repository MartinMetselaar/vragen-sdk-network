import Foundation
import Moya
import VragenAPIModels

/// See `SurveyAnswerService` for documentation about the different endpoints.
public class SurveyAsynchroniseNetwork: SurveyAsynchroniseNetworkable {
    public let provider: MoyaProvider<SurveyService>

    public convenience init(server: URL, token: String) {
        self.init(provider: VragenProvider<SurveyService>(server: server, token: token))
    }

    internal init(provider: MoyaProvider<SurveyService>) {
        self.provider = provider
    }

    public func getWithChildren(identifier: UUID, completion: @escaping (_ result: Result<SurveyWithQuestionsResponse, MoyaError>) -> Void) {
        provider.request(.getWithChildren(identifier: identifier), to: SurveyWithQuestionsResponse.self, completion: completion)
    }
}

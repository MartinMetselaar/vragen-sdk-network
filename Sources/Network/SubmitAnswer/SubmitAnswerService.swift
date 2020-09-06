import Foundation
import VragenAPIModels
import Moya

/// See `SubmitAnswerNetworkable` for documentation about the different endpoints.
public enum SubmitAnswerService {
    case submit(input: SubmitAnswerRequest)
}

extension SubmitAnswerService: TargetType {
    public var path: String {
        switch self {
            case .submit:
                return "/api/v1/submit"
        }
    }

    public var method: Moya.Method {
        switch self {
            case .submit:
                return .post
        }
    }

    public var task: Task {
        switch self {
            case .submit(let parameters):
                return .requestJSONEncodable(parameters)
        }
    }

    public var headers: [String: String]? {
        return [
            "Content-type": "application/json",
        ]
    }
}

extension SubmitAnswerService: AccessTokenAuthorizable {
    public var authorizationType: AuthorizationType? { .bearer }
}

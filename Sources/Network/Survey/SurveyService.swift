import Foundation
import VragenAPIModels
import Moya

/// See `SurveyNetworkable` for documentation about the different endpoints.
public enum SurveyService {
    case list(page: Int?, per: Int?)
    case create(input: SurveyCreateRequest)
    case get(identifier: String)
    case getWithChildren(identifier: String)
    case update(identifier: String, input: SurveyCreateRequest)
    case delete(identifier: String)
}

extension SurveyService: TargetType {
    public var path: String {
        switch self {
            case .list(_, _), .create(_):
                return "/api/v1/surveys/"
            case .get(let identifier), .update(let identifier, _), .delete(let identifier):
                return "/api/v1/surveys/\(identifier)"
            case .getWithChildren(let identifier):
                return "/api/v1/surveys/\(identifier)/children"
        }
    }

    public var method: Moya.Method {
        switch self {
            case .list, .get, .getWithChildren:
                return .get
            case .create, .update:
                return .post
            case .delete:
                return .delete
        }
    }

    public var task: Task {
        switch self {
            case .list(let page, let per):
                var parameters: [String: Any] = [:]
                parameters["page"] = page
                parameters["per"] = per
                return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            case .create(let parameters), .update(_, let parameters):
                return .requestJSONEncodable(parameters)
            default:
                return .requestPlain
        }
    }

    public var headers: [String: String]? {
        return [
            "Content-type": "application/json",
        ]
    }
}

extension SurveyService: AccessTokenAuthorizable {
    public var authorizationType: AuthorizationType? { .bearer }
}

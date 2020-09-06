import Foundation
import VragenAPIModels
import Moya

/// See `AnswerNetworkable` for documentation about the different endpoints.
public enum AnswerService {
    case list(surveyId: String, questionId: String, page: Int?, per: Int?)
    case create(surveyId: String, questionId: String, input: QuestionCreateRequest)
    case get(surveyId: String, questionId: String, identifier: String)
    case update(surveyId: String, questionId: String, identifier: String, input: QuestionCreateRequest)
    case delete(surveyId: String, questionId: String, identifier: String)
}

extension AnswerService: TargetType {
    public var path: String {
        switch self {
            case .list(let surveyId, let questionId, _, _), .create(let surveyId, let questionId, _):
                return "/api/v1/surveys/\(surveyId)/questions/\(questionId)"
            case .get(let surveyId, let questionId, let identifier),
                 .update(let surveyId, let questionId, let identifier, _),
                 .delete(let surveyId, let questionId, let identifier):
                return "/api/v1/surveys/\(surveyId)/questions/\(questionId)/answers/\(identifier)"
        }
    }

    public var method: Moya.Method {
        switch self {
            case .list, .get:
                return .get
            case .create, .update:
                return .post
            case .delete:
                return .delete
        }
    }

    public var task: Task {
        switch self {
            case .list(_, _, let page, let per):
                var parameters: [String: Any] = [:]
                parameters["page"] = page
                parameters["per"] = per
                return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            case .create(_, _, let parameters), .update(_, _, _, let parameters):
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

extension AnswerService: AccessTokenAuthorizable {
    public var authorizationType: AuthorizationType? { .bearer }
}
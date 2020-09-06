import Foundation
import VragenAPIModels
import Moya

public enum QuestionService {

    /// Paginated list of questions.
    /// - Parameters:
    ///     - surveyId: id of the survey
    ///     - page: page index which starts at 1
    ///     - per: number of items per page
    case list(surveyId: UUID, page: Int?, per: Int?)

    /// Create a new question.
    /// - Parameters:
    ///     - surveyId: id of the survey
    ///     - input: input needed to create a question
    case create(surveyId: UUID, input: QuestionCreateRequest)

    /// Get a question.
    /// - Parameters:
    ///     - surveyId: id of the survey
    ///     - identifier: id of the question
    case get(surveyId: UUID, identifier: UUID)

    /// Update a question.
    /// - Parameters:
    ///   - surveyId: id of the survey
    ///   - identifier: id of the question
    ///   - input: input needed to update a question
    case update(surveyId: UUID, identifier: UUID, input: QuestionCreateRequest)

    /// Delete a question.
    /// - Parameters:
    ///     - surveyId: id of the survey
    ///     - identifier: id of the question
    case delete(surveyId: UUID, identifier: UUID)
}

extension QuestionService: TargetType {
    public var path: String {
        switch self {
            case .list(let surveyId, _, _), .create(let surveyId, _):
                return "/api/v1/surveys/\(surveyId)/questions/"
            case .get(let surveyId, let identifier),
                 .update(let surveyId, let identifier, _),
                 .delete(let surveyId, let identifier):
                return "/api/v1/surveys/\(surveyId)/questions/\(identifier)"
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
            case .list(_, let page, let per):
                var parameters: [String: Any] = [:]
                parameters["page"] = page
                parameters["per"] = per
                return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            case .create(_, let parameters), .update(_, _, let parameters):
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

extension QuestionService: AccessTokenAuthorizable {
    public var authorizationType: AuthorizationType? { .bearer }
}

import Foundation
import VragenAPIModels
import Moya

public enum AnswerService {

    /// Paginated list of answers.
    /// - Parameters:
    ///     - surveyId: id of the survey
    ///     - questionId: id of the question
    ///     - page: page index which starts at 1
    ///     - per: number of items per page
    case list(surveyId: UUID, questionId: UUID, page: Int?, per: Int?)

    /// Create a new answer.
    /// - Parameters:
    ///     - surveyId: id of the survey
    ///     - questionId: id of the question
    ///     - input: input needed to create an answer
    case create(surveyId: UUID, questionId: UUID, input: AnswerCreateRequest)

    /// Get a question.
    /// - Parameters:
    ///     - surveyId: id of the survey
    ///     - questionId: id of the question
    ///     - identifier: id of the answer
    case get(surveyId: UUID, questionId: UUID, identifier: UUID)

    /// Update a question.
    /// - Parameters:
    ///   - surveyId: id of the survey
    ///   - questionId: id of the question
    ///   - identifier: id of the answer
    ///   - input: input needed to update an answer
    case update(surveyId: UUID, questionId: UUID, identifier: UUID, input: AnswerCreateRequest)

    /// Delete a question.
    /// - Parameters:
    ///     - surveyId: id of the survey
    ///     - questionId: id of the question
    ///     - identifier: id of the answer
    case delete(surveyId: UUID, questionId: UUID, identifier: UUID)
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

import Foundation
import VragenAPIModels
import Moya

public enum SurveyService {

    /// Paginated list of surveys.
    /// - Parameters:
    ///     - page: page index which starts at 1
    ///     - per: number of items per page
    case list(page: Int?, per: Int?)

    /// Create a new survey.
    /// - Parameter input: input needed to create a survey
    case create(input: SurveyCreateRequest)

    /// Get a survey.
    /// - Parameter identifier: id of the survey
    case get(identifier: UUID)

    /// Get a survey which will include all its children (questions and possible answers).
    /// - Parameter identifier: id of the survey
    case getWithChildren(identifier: UUID)

    /// Update a survey.
    /// - Parameters:
    ///     - identifier: id of the survey
    ///     - input: input needed to update a survey
    case update(identifier: UUID, input: SurveyCreateRequest)

    /// Delete a survey.
    /// - Parameter identifier: id of the survey
    case delete(identifier: UUID)

    /// Retrieve results of a survey.
    /// - Parameter identifier: id of the survey
    case results(identifier: UUID)
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
            case .results(let identifier):
                return "/api/v1/surveys/\(identifier)/results"
        }
    }

    public var method: Moya.Method {
        switch self {
            case .list, .get, .getWithChildren, .results:
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

import Foundation

public class EmptyResponse: Decodable, Equatable {
    public static func == (lhs: EmptyResponse, rhs: EmptyResponse) -> Bool {
        return true
    }
}

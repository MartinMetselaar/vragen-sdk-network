import Foundation
import Moya

/// Default implementation for `TargetType` properties.
extension TargetType {
    public var baseURL: URL {
        fatalError("Don't forget to use the VragenProvider instead of the MoyaProvider or override this")
    }

    public var sampleData: Data {
        Data()
    }
}

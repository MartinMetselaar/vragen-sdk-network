import Foundation
import Moya

/// An extension on MoyaProvider to init with server and token.
public class VragenProvider<Target: TargetType>: MoyaProvider<Target> {

    /// Init to instantiate class with a server and an authentication token needed for that server
    /// which inits with a custom `endpointClosure` and the `AccessTokenPlugin`.
    /// - Parameters:
    ///   - server: baseURL of server that is running the Vragen API
    ///   - token: authentication token for the server
    convenience init(server: URL, token: String) {
        self.init(endpointClosure: { target -> Endpoint in
            let urlString = server.appendingPathComponent(target.path).absoluteString

            return Endpoint(target: target, url: urlString)
        }, plugins: [
            AccessTokenPlugin { _ in token },
        ])
    }
}

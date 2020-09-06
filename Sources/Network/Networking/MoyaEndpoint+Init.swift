import Moya

/// Convenience init to init `Endpoint` with a different url and retrieve the rest of the properties from the target.
extension Endpoint {
    convenience init(target: TargetType, url: String) {
        self.init(
            url: url,
            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
    }
}

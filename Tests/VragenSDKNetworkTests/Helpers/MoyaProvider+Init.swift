import Moya

extension MoyaProvider {

    convenience init(response: EndpointSampleResponse) {
        let customEndpointClosure = { (target: Target) -> Endpoint in
            return Endpoint(
                url: "https://github.com", // Will not be called but needs a valid url
                sampleResponseClosure: { response },
                method: target.method,
                task: target.task,
                httpHeaderFields: target.headers
            )
        }

        self.init(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
    }
}

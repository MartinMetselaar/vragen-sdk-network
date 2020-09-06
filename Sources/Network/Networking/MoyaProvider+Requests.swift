import Foundation
import Moya

extension MoyaProvider {

    /// Request that already decodes the data of the response when the request is successful.
    @discardableResult
    func request<T: Decodable>(_ target: Target, callbackQueue: DispatchQueue? = .main, progress: ProgressBlock? = .none, to type: T.Type, completion: @escaping (_ result: Result<T, MoyaError>) -> Void) -> Cancellable {
        return request(target, callbackQueue: callbackQueue) { (result) in
            switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let value):
                    do {
                        let data = try value.map(type, failsOnEmptyData: !(type is EmptyResponse.Type))
                        completion(.success(data))
                    } catch {
                        completion(.failure(MoyaError.jsonMapping(value)))
                    }
            }
        }
    }
}

// MARK: - Synchronise
extension MoyaProvider {

    /// Request that already decodes the data of the response when the request is successful while doing this **synchronously** with the use of `DispatchSemaphore`.
    func request<T: Decodable>(_ target: Target, progress: ProgressBlock? = .none, to type: T.Type) -> Result<T, MoyaError> {
        let semaphore = DispatchSemaphore(value: 0)

        var response: Result<T, MoyaError> = .failure(MoyaError.underlying(RequestNeverExecutedError(), nil))
        request(target, callbackQueue: .global(qos: .background), to: type) { (result) in
            defer { semaphore.signal() }
            response = result
        }

        semaphore.wait()

        return response
    }
}

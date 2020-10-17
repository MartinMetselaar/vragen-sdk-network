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

    /// Request that maps the response to a string when the request is successful while doing this **synchronously** with the use of `DispatchSemaphore`.
    func request(_ target: Target, progress: ProgressBlock? = .none) -> Result<String, MoyaError> {
        let semaphore = DispatchSemaphore(value: 0)

        var response: Result<String, MoyaError> = .failure(MoyaError.underlying(RequestNeverExecutedError(), nil))
        request(target, callbackQueue: .global(qos: .background)) { (result) in
            defer { semaphore.signal() }
            switch result {
                case .failure(let error):
                    response = .failure(error)
                case .success(let value):
                    let responseString = String(data: value.data, encoding: .utf8) ?? ""
                    response = .success(responseString)
            }
        }

        semaphore.wait()

        return response
    }
}

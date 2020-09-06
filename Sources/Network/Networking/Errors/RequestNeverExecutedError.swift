import Foundation

/// Request that helps with creating a result while waiting for an asynchronise request to inform that the request never happened or did not wait for it to happen
public struct RequestNeverExecutedError: Error, CustomStringConvertible {
    public var description: String = "Request was never executed"
}

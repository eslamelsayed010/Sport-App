//
//  MockNetworkRequester.swift
//  Sport AppTests
//
//  Created by Macos on 22/05/2025.
//

import Foundation
@testable import Sport_App
import Alamofire


class MockNetworkRequester: NetworkRequesting {
    var mockResult: Any?
    var shouldFail = false
    var error: Error = NSError(domain: "", code: 0, userInfo: nil)

    func request<T>(_ url: URLConvertible, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        if shouldFail {
            completion(.failure(error))
        } else if let result = mockResult as? T {
            completion(.success(result))
        }
    }
}

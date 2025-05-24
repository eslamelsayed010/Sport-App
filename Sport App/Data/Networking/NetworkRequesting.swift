//
//  NetworkRequesting.swift
//  Sport App
//
//  Created by Macos on 22/05/2025.
//

import Foundation
import Alamofire

protocol NetworkRequesting {
    func request<T: Decodable>(_ url: URLConvertible, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

class AlamofireNetworkRequester: NetworkRequesting {
    func request<T>(_ url: URLConvertible, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        AF.request(url).responseDecodable(of: responseType) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


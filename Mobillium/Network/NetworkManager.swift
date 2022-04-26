//
//  NetworkManager.swift
//  Mobillium
//
//  Created by Ali Mert Özhayta on 26.04.2022.
//

import Alamofire

typealias Response<T> = DataResponse<T, AFError>

final class NetworkManager {
    private static let apiKey = "a378b5d1ec04d6c21a8ae54507b55641"
    private static let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhMzc4YjVkMWVjMDRkNmMyMWE4YWU1NDUwN2I1NTY0MSIsInN1YiI6IjVlMDM2MDM3MjZkYWMxMDAxMjY4YzJjNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.k4UKfJ5B1ZZJAWHWAGCEQmLyUP2QzhHR54VTeHMr6-8"

    private static func getHeaders() -> HTTPHeaders {
        HTTPHeaders([
            "Authorization": "Bearer \(NetworkManager.accessToken)",
            "Content-Type":  "application/json;charset=utf-8"
        ])
    }

    private static func getParameters() -> Parameters {
        ["api_key": NetworkManager.apiKey, "language": "en"]
    }
}

// MARK: NetworkManager Public Methods

extension NetworkManager {


    static func request<T: Decodable>(
        _ endpoint: String,
        method: HTTPMethod = .get,
        _ T: T.Type,
        completion: @escaping (Response<T>) -> Void
    ) {
        DispatchQueue.main.async {
            AF.request(
                endpoint,
                method: method,
                parameters: NetworkManager.getParameters(),
                headers: NetworkManager.getHeaders()
            ).responseDecodable { (response: DataResponse<T, AFError>) in
                completion(response)
            }
        }
    }
}

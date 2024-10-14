//
//  NetworkManager.swift
//  NewsTime
//
//  Created by Oleksandr Sysenko on 20.04.2022.
//

import Alamofire
import Foundation
import Combine

final class NetworkManager: NetworkManagerProtocol {
    private let accessToken = "5kpiS98wmgNaOmm0MDAK1amNTEUelLUq"
    private let parameterName = "api-key"
    let baseUrl = "https://api.nytimes.com/svc/mostpopular/v2"

    func loadData<T: Decodable>(url: URL) -> AnyPublisher<T, AFError> {
        guard var urlComponents = URLComponents(string: url.absoluteString) else {
            return Fail(error: AFError.invalidURL(url: url.absoluteString)).eraseToAnyPublisher()
        }
        let accessQuerryItem = URLQueryItem(name: parameterName,
                                            value: accessToken)
        urlComponents.queryItems = [accessQuerryItem]
        let request = AF.request(urlComponents)
        return request.publishDecodable(type: T.self).value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
    

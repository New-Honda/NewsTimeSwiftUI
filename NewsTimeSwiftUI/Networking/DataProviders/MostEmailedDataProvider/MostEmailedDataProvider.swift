//
//  MostEmailedDataProvider.swift
//  NewsTime
//
//  Created by Oleksandr Sysenko on 20.04.2022.
//

import Alamofire
import Foundation
import Combine

final class MostEmailedDataProvider: DataProviderProtocol {
    private let networkManager: NetworkManagerProtocol = NetworkManager()

    func getData() -> AnyPublisher<ContentModel, AFError> {
        let path = networkManager.baseUrl + "/emailed/30.json"

        guard let url = URL(string: path) else {
            return Fail(error: AFError.invalidURL(url: path)).eraseToAnyPublisher()
        }

        return networkManager.loadData(url: url)
    }
}

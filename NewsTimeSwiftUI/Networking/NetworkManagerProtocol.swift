//
//  NetworkManagerProtocol.swift
//  NewsTime
//
//  Created by Oleksandr Sysenko on 20.04.2022.
//

import Alamofire
import Combine
import Foundation

protocol NetworkManagerProtocol {
    var baseUrl: String { get }
    func loadData<T: Decodable>(url: URL) -> AnyPublisher<T, AFError>
}

protocol DataProviderProtocol {
    func getData() -> AnyPublisher<ContentModel, AFError>
}

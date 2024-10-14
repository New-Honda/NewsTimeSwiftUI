//
//  NewsAPIViewModel.swift
//  NewsTimeSwiftUI
//
//  Created by Developer on 13.10.2024.
//

import Foundation
import CoreData
import SwiftUI
import Combine

class NewsAPIViewModel: ObservableObject, NewsViewModelProtocol {

    enum APIType {
        case mostEmailed
        case mostShared
        case mostViewed
    }

    @Published var items: [ArticleModel] = []
    private var viewContext: NSManagedObjectContext
    private var apiType: APIType
    private var task: AnyCancellable?
    private let provider: DataProviderProtocol

    init(viewContext: NSManagedObjectContext, apiType: APIType) {
        self.viewContext = viewContext
        self.apiType = apiType

        switch apiType {
        case .mostEmailed:
            provider = MostEmailedDataProvider()
        case .mostShared:
            provider = MostSharedDataProvider()
        case .mostViewed:
            provider = MostViewedDataProvider()
        }
    }

    func favoriteAction(article: ArticleModel) {
        PersistenceController.shared.addArticle(articleModel: article, context: viewContext)
        getAllItems()
    }

    func getAllItems() {
        task = provider.getData().sink(receiveCompletion: { _ in
        }, receiveValue: { [weak self] response in
            self?.items = response.results
        })
    }
}

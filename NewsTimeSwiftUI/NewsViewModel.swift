//
//  NewsViewModel.swift
//  NewsTimeSwiftUI
//
//  Created by Developer on 10.10.2024.
//

import Foundation
import CoreData
import SwiftUI

class NewsViewModel: ObservableObject, NewsViewModelProtocol {

    @Published var items: [ArticleModel] = []
    private var viewContext: NSManagedObjectContext

    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }

    func favoriteAction(article: ArticleModel) {
        PersistenceController.shared.removeArticle(articleId: article.id, context: viewContext)
        getAllItems()
    }

    func getAllItems() {
        items = PersistenceController.shared.getAllItems(context: viewContext).compactMap { $0.getArticleModel() }
    }
}

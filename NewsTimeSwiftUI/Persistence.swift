//
//  Persistence.swift
//  NewsTimeSwiftUI
//
//  Created by Developer on 29.09.2024.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for index in 0..<10 {
            let newItem = Article(context: viewContext)
            newItem.id = Int64(index)
            newItem.title = "Title \(index)"
            newItem.section = "Section \(index)"
            newItem.byLine = "byLine \(index)"
            newItem.abstract = "abstract \(index)"
            newItem.publishedDate = "2024-09-29"
            newItem.url = "https://www.google.com"

            let mediaMeta = MediaMetaData(context: viewContext)

            mediaMeta.format = "png"
            mediaMeta.height = 200
            mediaMeta.width = 300
            mediaMeta.url = "https://fastly.picsum.photos/id/238/200/300"
            let media = Media(context: viewContext)
            media.copyright = "copyright"
            media.medias = Set([mediaMeta])

            newItem.medis = Set([media])
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "NewsTimeSwiftUI")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    // save the changes on your context to the persistent store
    func saveContext() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }

    func getAllItems(context: NSManagedObjectContext) -> [Article] {
        let request = NSFetchRequest<Article>(entityName: "Article")

        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }

    func addArticle(articleModel: ArticleModel, context: NSManagedObjectContext) {
        let article = Article(context: context)
        article.id = Int64(articleModel.id)
        article.title = articleModel.title
        article.section = articleModel.section
        article.byLine = articleModel.byLine
        article.abstract = articleModel.abstract
        article.publishedDate = articleModel.publishedDate
        article.url = articleModel.url

        articleModel.media.forEach { media in
            let mediaData = Media(context: context)
            mediaData.copyright = media.copyright
            media.medias.forEach { meta in
                let metaData = MediaMetaData(context: context)
                metaData.setMediaMetaData(mediaMetaDataModel: meta)
                mediaData.addToMedias(metaData)
            }
            article.addToMedis(mediaData)
        }
        do {
            try context.save()
        } catch {
            NSLog("SetData error")
        }
    }

    func removeArticle(articleId: Int, context: NSManagedObjectContext) {
        let request = NSFetchRequest<Article>(entityName: "Article")
        request.predicate = NSPredicate(format: "id == \(articleId)")

        do {
            let article = try context.fetch(request).first
            if let article = article {
                context.delete(article)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

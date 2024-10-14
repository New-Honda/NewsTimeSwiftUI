//
//  Article+CoreDataProperties.swift
//  NewsTimeSwiftUI
//
//  Created by Developer on 11.10.2024.
//
//

import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var abstract: String?
    @NSManaged public var byLine: String?
    @NSManaged public var id: Int64
    @NSManaged public var publishedDate: String?
    @NSManaged public var section: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var medis: Set<Media>?

}

// MARK: Generated accessors for medis
extension Article {

    @objc(addMedisObject:)
    @NSManaged public func addToMedis(_ value: Media)

    @objc(removeMedisObject:)
    @NSManaged public func removeFromMedis(_ value: Media)

    @objc(addMedis:)
    @NSManaged public func addToMedis(_ values: NSSet)

    @objc(removeMedis:)
    @NSManaged public func removeFromMedis(_ values: NSSet)

}

extension Article : Identifiable {

}

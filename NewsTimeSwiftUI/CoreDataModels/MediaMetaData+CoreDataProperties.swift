//
//  MediaMetaData+CoreDataProperties.swift
//  NewsTimeSwiftUI
//
//  Created by Developer on 11.10.2024.
//
//

import Foundation
import CoreData


extension MediaMetaData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MediaMetaData> {
        return NSFetchRequest<MediaMetaData>(entityName: "MediaMetaData")
    }

    @NSManaged public var format: String?
    @NSManaged public var height: Int64
    @NSManaged public var url: String?
    @NSManaged public var width: Int64
    @NSManaged public var relationship: Media?

}

extension MediaMetaData : Identifiable {

}

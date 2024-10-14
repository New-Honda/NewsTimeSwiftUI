//
//  MediaMetaData+CoreDataClass.swift
//  NewsTimeSwiftUI
//
//  Created by Developer on 11.10.2024.
//
//

import Foundation
import CoreData

@objc(MediaMetaData)
public class MediaMetaData: NSManagedObject {
    func getMediaMetaDataModel() -> MediaMetaDataModel? {
        guard let url = url, let format = format else { return nil }
        return MediaMetaDataModel(url: url,
                                  format: format,
                                  height: Int(height),
                                  width: Int(width))
    }

    func setMediaMetaData(mediaMetaDataModel: MediaMetaDataModel) {
        url = mediaMetaDataModel.url
        format = mediaMetaDataModel.format
        height = Int64(mediaMetaDataModel.height)
        width = Int64(mediaMetaDataModel.width)
    }
}

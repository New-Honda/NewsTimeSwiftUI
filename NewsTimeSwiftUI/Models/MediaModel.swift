//
//  MediaModel.swift
//  NewsTime
//
//  Created by Oleksandr Sysenko on 19.04.2022.
//

import UIKit

struct MediaModel: Decodable, Hashable {
    var copyright: String
    var medias: [MediaMetaDataModel]

    enum CodingKeys: String, CodingKey {
        case copyright
        case medias = "media-metadata"
    }
}

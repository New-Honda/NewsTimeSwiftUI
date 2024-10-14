//
//  MediaMetaDataModel.swift
//  NewsTime
//
//  Created by Oleksandr Sysenko on 19.04.2022.
//

struct MediaMetaDataModel: Decodable, Hashable {
    var url: String
    var format: String
    var height: Int
    var width: Int
}

//
//  ArticleModel.swift
//  NewsTime
//
//  Created by Oleksandr Sysenko on 19.04.2022.
//

import UIKit

struct ArticleModel: Decodable, Hashable, Identifiable {
    var id: Int
    var url: String
    var section: String
    var byLine: String
    var title: String
    var abstract: String
    var publishedDate: String
    var media: [MediaModel]

    enum CodingKeys: String, CodingKey {
        case id
        case url
        case section
        case byLine = "byline"
        case title
        case abstract
        case publishedDate = "published_date"
        case media
    }
}

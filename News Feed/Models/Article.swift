//
//  Article.swift
//  News Feed
//
//  Created by Jason Howk on 8/7/18.
//  Copyright © 2018 Rude Tie, LLC. All rights reserved.
//

import Foundation

struct Article: Codable {
    struct Source: Codable {
        var id: String?
        var name: String?
    }
    
    var source: Source
    var author: String?
    var title: String
    var description: String?
    var url: String
    var imageURL: String?
    var datePublished: Date
    
    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case url
        case imageURL = "urlToImage"
        case datePublished = "publishedAt"
    }
}

extension Article: CustomDebugStringConvertible {
    var debugDescription: String {
        return "Article(title:\(title), url:\(url))"
    }
}

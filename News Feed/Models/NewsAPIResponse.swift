//
//  NewsAPIResponse.swift
//  News Feed
//
//  Created by Jason Howk on 8/7/18.
//  Copyright © 2018 Rude Tie, LLC. All rights reserved.
//

import Foundation

struct NewsAPIResponse: Codable {
    var status: String
    var code: String?
    var message: String?
    var totalResults: Int?
    var articles:[Article]?
}

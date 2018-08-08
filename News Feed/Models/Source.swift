//
//  Source.swift
//  News Feed
//
//  Created by Jason Howk on 8/7/18.
//  Copyright © 2018 Rude Tie, LLC. All rights reserved.
//

import Foundation

struct Source: Codable {
    var id: String
    var name: String
}

extension Source:CustomDebugStringConvertible {
    var debugDescription: String {
        return "Source -- id:\(id), name:\(name)"
    }
}

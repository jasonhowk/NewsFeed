//
//  ServiceCoordinator.swift
//  News Feed
//
//  Created by Jason Howk on 8/8/18.
//  Copyright © 2018 Rude Tie, LLC. All rights reserved.
//

import Foundation


/// The ServiceCoordinator orchestrates and manages access to the applications services.
class ServiceCoordinator {
    
    // Config Items.
    private let newsAPIKey = "0f7cae49ce404bebaafbe47332970a4c"
    
    // Services
    lazy var newsService:NewsAPIService = NewsAPIService(withKey: newsAPIKey)
    lazy var imageServer:ImageRequesterService = ImageRequesterService()
    
    // Singleton
    static let sharedInstance = ServiceCoordinator()
    private init() {}
    
}

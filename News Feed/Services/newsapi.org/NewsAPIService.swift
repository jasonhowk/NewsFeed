//
//  NewsApiService.swift
//  News Feed
//
//  Created by Jason Howk on 8/7/18.
//  Copyright © 2018 Rude Tie, LLC. All rights reserved.
//

import Foundation

typealias RequestCompletionHandler = (Data?, URLResponse?, Error?) -> Void

class NewsAPIService {
    // Config Items.
    private let defaultTimeoutInterval = 10.0
    private let baseURL:String = "https://newsapi.org"
    private let defaultTopHeadlinesPath = "/v2/top-headlines"
    private let defaultEverythingPath = "/v2/everything"
    private let defaultSourcesPath = "/v2/sources"
    
    /// The newsapi.org API key.
    /// - SeeAlso: https://newsapi.org/docs/authentication
    var apiKey:String!
    
    required init(withKey key:String) {
        apiKey = key
        debugPrint("Creating NewsAPIService with key: \(key)")
    }
    
    // MARK: - Public
    func requestTopHeadlines(completionHandler: @escaping RequestCompletionHandler) {
        // REQUEST PARAMS: country, category, sources, q (keyword to search), pagesize, page
        // RESPONSE: status, totalResults, articles (array[article])
        let topHeadlinesURLString = baseURL + defaultTopHeadlinesPath
        requestURL(topHeadlinesURLString, completionHandler: completionHandler)
    }
    
    func everything() {
        // REQUEST: q (keyword to search), sources, domains, from, to, language, sortBy, pagesize, page
        // RESPONSE: status, totalResults, articles,
    }
    
    func sources() {
        // REQUEST: category, language, country
        // RESPONSE: status, sources (array[source])
    }
    
    // MARK: - Private
    private func requestURL(_ urlString:String, completionHandler:@escaping RequestCompletionHandler ) {
        // Configure Session
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.requestCachePolicy = .useProtocolCachePolicy
        sessionConfig.timeoutIntervalForRequest = defaultTimeoutInterval
        
        // Create Session
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        // Create the URL
        guard var urlComponents = URLComponents(string: urlString) else { return }
        urlComponents.queryItems = [
            URLQueryItem(name: "country", value: "us")
        ]
        guard let url = urlComponents.url else { return }
        debugPrint("Created URL: \(url)")
        
        // Create request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "Authorization")
        
        // Create Task
        let task = session.dataTask(with: request, completionHandler: completionHandler)
        task.resume()
        session.finishTasksAndInvalidate()
    }
}

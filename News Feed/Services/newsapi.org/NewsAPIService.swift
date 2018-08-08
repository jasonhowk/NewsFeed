//
//  NewsApiService.swift
//  News Feed
//
//  Created by Jason Howk on 8/7/18.
//  Copyright © 2018 Rude Tie, LLC. All rights reserved.
//

import Foundation

/// A Clousure that receives the newsapi.org data requested.
typealias NewsAPIRequestCompletionHandler = (NewsAPIResponse?, ServiceResult) -> Void

/// The status of a given NewAPIService request.
///
/// - success: The requested operation was successful.
/// - failure: The requested operation was unsuccessful.  The error is supplied as an associated value.
enum ServiceResult {
    case success
    case failure(error: Error)
}

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
    
    /// Asyncronously retrieves the top headlines.
    ///
    /// - Parameter completionHandler: The `NewsAPIRequestCompletionHandler` that will be invoked once the request is completed.
    func requestTopHeadlines(completionHandler:@escaping NewsAPIRequestCompletionHandler){
        // REQUEST PARAMS: country, category, sources, q (keyword to search), pagesize, page
        // RESPONSE: status, totalResults, articles (array[article])
        let topHeadlinesURLString = baseURL + defaultTopHeadlinesPath
        requestURL(topHeadlinesURLString) { (data, response, error) in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                if statusCode == 200 {
                    if let jsonData = data {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        do {
                            let apiResponse = try decoder.decode(NewsAPIResponse.self, from: jsonData)
                            completionHandler(apiResponse, .success)
                        } catch DecodingError.dataCorrupted(let context) {
                            debugPrint("Error decoding JSON resposnse.")
                            completionHandler(nil,.failure(error: DecodingError.dataCorrupted(context)))
                        } catch let decodeError {
                            completionHandler(nil,.failure(error: decodeError))
                        }
                    }
                }
            }
            else {
                // Failure
                debugPrint("URL Request Failed: %@", error!.localizedDescription)
                completionHandler(nil,.failure(error: error!))
            }
        }
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
    private func requestURL(_ urlString:String, completionHandler:@escaping (Data?, URLResponse?, Error?) -> Void) {
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

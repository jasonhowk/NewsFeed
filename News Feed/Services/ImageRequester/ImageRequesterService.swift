//
//  ImageRequesterService.swift
//  News Feed
//
//  Created by Jason Howk on 8/8/18.
//  Copyright © 2018 Rude Tie, LLC. All rights reserved.
//

import Foundation
import UIKit

class ImageRequesterService {
    // CONFIG
    private let defaultTimeoutInterval = 10.0
    
    // Properties.
    lazy private var placeholderImage:UIImage = #imageLiteral(resourceName: "Placeholder2")
    
    // MARK: - Public
    func requestImageFromURL(_ urlString:String, completionHandler:@escaping (UIImage?, Error?) -> Void) {
        // request image.
        requestImageFromURL(urlString) { (data, response, error) in
            // grab image and create UIImage
            if let error = error {
                completionHandler(self.placeholderImage, error)
            } else {
                var image = self.placeholderImage
                if let imageData = data, let resultImage = UIImage(data: imageData) {
                    image = resultImage
                }
                completionHandler(image, nil)
            }
        }
    }
    
    // MARK: - Private
    private func requestImageFromURL(_ urlString:String, completionHandler:@escaping (Data?, URLResponse?, Error?) -> Void) {
        // Configure Session
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.requestCachePolicy = .returnCacheDataElseLoad
        sessionConfig.timeoutIntervalForRequest = defaultTimeoutInterval
        
        // Create Session
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        // Create the URL
        guard let urlComponents = URLComponents(string: urlString) else { return }
        guard let url = urlComponents.url else { return }
        // debugPrint("Created URL: \(url)")
        
        // Create request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Create Task
        let task = session.dataTask(with: request, completionHandler: completionHandler)
        task.resume()
        session.finishTasksAndInvalidate()
    }
}

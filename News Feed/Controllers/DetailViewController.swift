//
//  DetailViewController.swift
//  News Feed
//
//  Created by Jason Howk on 8/8/18.
//  Copyright © 2018 Rude Tie, LLC. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var tldrView: TLDRView!
    @IBOutlet weak var webView: WKWebView!
    
    var article:Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configure Web View
        webView.uiDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        if let article = article, let url = URL(string: article.url) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        // Configure TL;DR View
        tldrView.articlePublishedDate = article?.datePublished
        if let description = article?.description, description.isEmpty {
            tldrView.articleDescription = "No description available."
        } else {
            tldrView.articleDescription = article?.description
        }
            
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension DetailViewController: WKUIDelegate {
    
}

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
    @IBOutlet weak var tldrView: UIView!
    @IBOutlet weak var webView: WKWebView!
    
    var article:Article?
    
    override func awakeFromNib() {
        super .awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configure Web View
        webView.uiDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        if let article = article, let url = URL(string: article.url) {
            let request = URLRequest(url: url)
            self.webView.load(request)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension DetailViewController: WKUIDelegate {
    
}

//
//  MasterTableViewController.swift
//  News Feed
//
//  Created by Jason Howk on 8/8/18.
//  Copyright © 2018 Rude Tie, LLC. All rights reserved.
//

import UIKit

class MasterTableViewController: UITableViewController {
    
    private var articles:[Article] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    private lazy var newsAPI:NewsAPIService = NewsAPIService(withKey: "0f7cae49ce404bebaafbe47332970a4c")
    private var refresh:UIRefreshControl = UIRefreshControl()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure refresh control
        refreshControl = refresh
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
        // Grab the data...
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "masterCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = articles[indexPath.row].title

        return cell
    }

    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint("Did Select item @ indexPath: \(indexPath.row)")
    }
    
    // MARK: - Private
    @objc private func loadData() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        // Grab the top headlines from the NewsAPI service.
        newsAPI.requestTopHeadlines { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    if let articles = response.articles {
                        self.articles = articles
                    }
                case .failure:
                    // TODO: Create proper error.
                    debugPrint("Print error.")
                }
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.refreshControl?.endRefreshing()
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

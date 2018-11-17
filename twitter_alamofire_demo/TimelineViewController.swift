//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Aristotle on 2018-08-11.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nav = self.navigationController?.navigationBar
        nav!.barTintColor = UIColor(red:0.11, green:0.63, blue:0.95, alpha:1.0)
        nav!.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: #selector(TimelineViewController.didPullToRefresh(_:)), for: .valueChanged)

        tableView.dataSource = self
        tableView.rowHeight = 180
        tableView.estimatedRowHeight = 180
        
        tableView.insertSubview(refreshControl, at: 0)
        
        fetchTweets()
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        fetchTweets()
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        
        //print("Log Out Successfully")
        let actionSheet = UIAlertController(title: "Closing Session", message: "Are you sure you want to log Out?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Disconnect Session", style: .default, handler: {(UIAlertAction) in
            APIManager.shared.logout()
            //NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        
        return cell
        
    }
    
    func fetchTweets() {
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                self.tweets = tweets!
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

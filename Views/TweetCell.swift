//
//  TweetCell.swift
//  Twitter
//
//  Created by Isaac Samuel on 11/13/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import Alamofire
import KeychainAccess
import OAuthSwiftAlamofire
import OAuthSwift
import AlamofireImage


class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var replyButton: UIImageView!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var countRetweetLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var countFavoriteLabel: UILabel!
    
    var profileUrl: NSURL?
    private var TimelineViewController: UIViewController!
    var tweet: Tweet! {
        didSet{
            refreshTweetData()
        }
        
    }
    func refreshTweetData(){
        tweetTextLabel.text = tweet.text
        profileNameLabel.text = tweet.user?.name
        usernameLabel.text = "@" + (tweet.user?.screenName as! String)
        profileImageView.af_setImage(withURL: tweet.user?.profileUrl! as! URL)
        timestampLabel.text = tweet.timeElapsed()
        countRetweetLabel.text = String(tweet.retweetCount)
        countFavoriteLabel.text = String(tweet.favoriteCount)
        
        profileImageView.layer.cornerRadius = 35
        profileImageView.clipsToBounds = true
        selectionStyle = .none
        
        if(tweet.retweeted!) {
            retweetButton.setImage(#imageLiteral(resourceName:"retweet-icon-green"), for: .normal)
        } else {
            retweetButton.setImage(#imageLiteral(resourceName:"retweet-icon"), for: .normal)
        }
        
        if(tweet.favorited!) {
            favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
        } else {
            favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
        }

    }
    
    @IBAction func onTapRetweet(_ sender: Any) {
        if(tweet.retweeted!) {
            // TODO: Update the local tweet model
            tweet.retweeted = false
            tweet.retweetCount -= 1
            // TODO: Update cell UI
            refreshTweetData()
            // TODO: Send a POST request to the POST favorites/create endpoint
            
            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let error = error {
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Tweet unretweeted succesfully: \(tweet.text!)")
                }
            }
        } else {
            // TODO: Update the local tweet model
            tweet.retweeted = true
            tweet.retweetCount += 1
            // TODO: Update cell UI
            refreshTweetData()
            
            // TODO: Send a POST request to the POST favorites/create endpoint
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Tweet retweeted succesfully: \(tweet.text!)")
                }
            }
        }
    }
    
    @IBAction func onTapFavorite(_ sender: Any) {
        if(tweet.favorited!) {
            // TODO: Update the local tweet model
            tweet.favorited = false
            tweet.favoriteCount -= 1
            // TODO: Update cell UI
            refreshTweetData()
            // TODO: Send a POST request to the POST favorites/create endpoint
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Tweet unfavorited succesfully: \(tweet.text!)")
                }
            }
        } else {
            // TODO: Update the local tweet model
            tweet.favorited = true
            tweet.favoriteCount += 1
            // TODO: Update cell UI
            refreshTweetData()
            // TODO: Send a POST request to the POST favorites/create endpoint
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Tweet favorited succesfully: \(tweet.text!)")
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

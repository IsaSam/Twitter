//
//  Tweet.swift
//  twitter_alamofire_demo
//
//  Created by Aristotle on 2018-10-05.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    // MARK: Properties
    var id: Int? // For favoriting, retweeting & replying
    var text: String? // Text content of tweet
    var favoriteCount: Int? // Update favorite count label
    var favorited: Bool? // Configure favorite button
    var retweetCount: Int? // Update favorite count label
    var retweeted: Bool? // Configure retweet button
    var user: User? // Author of the Tweet
    var createDate: NSDate?
    var createdAtString: String? // String representation of date posted
    var profileURL: User?
    
    // For Retweets
    var retweetedByUser: User?  // user who retweeted if tweet is retweet
    
    
    init(dictionary: [String : Any]) {
        super.init()
        
        var dictionary = dictionary
        
        // Is this a re-tweet?
        if let originalTweet = dictionary["retweeted_status"] as? [String: Any] {
            let userDictionary = dictionary["user"] as! [String: Any]
            self.retweetedByUser = User(dictionary: userDictionary)
            
            // Change tweet to original tweet
            dictionary = originalTweet
        }
        
        //id = dictionary["id"] as! Int64
        id = (dictionary["id"] as? Int) ?? 0
        text = dictionary["text"] as? String
        favoriteCount = dictionary["favorite_count"] as? Int
        favorited = dictionary["favorited"] as? Bool
        retweetCount = dictionary["retweet_count"] as? Int
        retweeted = dictionary["retweeted"] as? Bool
        // TODO: initialize user
        // TODO: Format and set createdAtString
        // initialize user
        let user = dictionary["user"] as! [String: Any]
        self.user = User(dictionary: user)
        let timeStampString = dictionary["created_at"] as? String
        if let timeStampString = timeStampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EE MM d HH:mm:ss Z y"
            createDate = formatter.date(from: timeStampString) as! NSDate
        }

        }
    func timeElapsed() -> String {
        let timeElapsedInSeconds = createDate?.timeIntervalSinceNow
        let time = abs(NSInteger(timeElapsedInSeconds!))
        if (time > 24 * 60 * 24) {
            return String(time / (24 * 60 * 24)) + "d"
        } else if (time > 60 * 60) {
            return String(time / (60 * 60)) + "h"
        } else {
            return String(time / 60) + "m"
        }
       /*
        // Format createdAt date string
        let createdAtOriginalString = dictionary["created_at"] as! String
        let formatter = DateFormatter()
        // Configure the input format to parse the date string
        formatter.dateFormat = "E MMM d HH:mm:ss Z y"
        // Convert String to Date
        let date = formatter.date(from: createdAtOriginalString)!
        // Configure output format
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        // Convert Date to String and set the createdAtString property
        createdAtString = formatter.string(from: date)
         */
    }
    
    static func tweets(with array: [[String: Any]]) -> [Tweet] {
        var tweets: [Tweet] = []
        for tweetDictionary in array {
            let tweet = Tweet(dictionary: tweetDictionary)
            tweets.append(tweet)
        }
        return tweets
    }
}

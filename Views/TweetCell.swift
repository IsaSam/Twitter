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
    
    
    var profileUrl: NSURL?
    private var TimelineViewController: UIViewController!
    var tweet: Tweet! {
        didSet{
            tweetTextLabel.text = tweet.text
            profileNameLabel.text = tweet.user?.name
            usernameLabel.text = "@" + (tweet.user?.screenName as! String)
            profileImageView.af_setImage(withURL: tweet.user?.profileUrl! as! URL)
            timestampLabel.text = tweet.timeElapsed()
            
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

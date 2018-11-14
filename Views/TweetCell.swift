//
//  TweetCell.swift
//  Twitter
//
//  Created by Isaac Samuel on 11/13/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    private var TimelineViewController: UIViewController!
    var tweet: Tweet! {
        didSet{
            tweetTextLabel.text = tweet.text
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

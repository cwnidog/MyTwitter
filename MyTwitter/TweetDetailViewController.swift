//
//  TweetDetailViewController.swift
//  MyTwitter
//
//  Created by John Leonard on 1/7/15.
//  Copyright (c) 2015 John Leonard. All rights reserved.
//

import UIKit
import Accounts
import Social

class TweetDetailViewController: UIViewController {
  
  var tweet: Tweet!
  
  @IBOutlet weak var favoriteCountLabel: UILabel!
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var tweetIdLabel: UILabel!
  @IBOutlet weak var tweetTextLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  
  var networkController :NetworkController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // get values out of the tweet adn display
    self.imageView.image = tweet.image
    self.tweetTextLabel.text = tweet.text
    self.userNameLabel.text = tweet.userName
    
    self.networkController.fetchTweetInfo(tweet.id, completionHandler: {(infoDictionary, errorString) -> () in
      println(infoDictionary)
      
      if errorString == nil {
        self.tweet.updateWithInfo(infoDictionary)
        self.favoriteCountLabel.text = self.tweet.favoriteCount
      } // no error
    })
    
    
    } // viewDidLoad()


} // DetailViewController

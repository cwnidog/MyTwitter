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

  @IBAction func ImageButtonPressed(sender: AnyObject) {
    let userVC = self.storyboard?.instantiateViewControllerWithIdentifier("USER_VC") as UserTimelineViewController
    userVC.networkController = self.networkController
    //userVC.userName = self.tweet.userName
    userVC.screenName = self.tweet.screenName
    
    self.navigationController?.pushViewController(userVC, animated: true)

  }

} // DetailViewController

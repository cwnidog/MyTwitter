//
//  ViewController.swift
//  MyTwitter
//
//  Created by John Leonard on 1/5/15.
//  Copyright (c) 2015 John Leonard. All rights reserved.
//

import UIKit
import Accounts
import Social

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  var tweets = [Tweet]()
  var networkController = NetworkController()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // we're our own tableView delegate
    self.tableView.delegate = self
    
    // we're our own data source
    self.tableView.dataSource = self
    
    self.tableView.registerNib(UINib(nibName: "CustomTweetCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "USER_TWEET_CELL")
    self.tableView.estimatedRowHeight = 144
    self.tableView.rowHeight = UITableViewAutomaticDimension
    
    // define the completion handler callback closure
    self.networkController.fetchHomeTimeline { (tweets, errorString) -> () in
      if errorString == nil{ // everything's OK
        self.tweets = tweets!
        self.tableView.reloadData()
      } // if errorString
      else {
        // put in some kind of error handler here
      }
    }
  } // override viewDidLoad()
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
  }

  // how many rows are there?
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.tweets.count
  } // tableView(numberOfRowsInSection)
  
  // what do we want to show?
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    // get the cell for this element of the tweets array
    let cell = tableView.dequeueReusableCellWithIdentifier("USER_TWEET_CELL", forIndexPath: indexPath) as CustomTweetCell
    
    // get he individual tweet
    let tweet = self.tweets[indexPath.row]
    
    cell.tweetLabel.text = tweet.text
    cell.userNameLabel.text = tweet.userName
    
    if tweet.image == nil {
      self.networkController.fetchImageForTweet(tweet, completionHandler: {(image) -> () in
      cell.userImageView.image = tweet.image
      })
    } // if image == nil
    else {
      cell.userImageView.image = tweet.image
    } // else

    return cell
  } // tableView(cellForRowAtIndexPath)
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    // instantiate the tweetVC
    let tweetVC = self.storyboard?.instantiateViewControllerWithIdentifier("TWEET_VC") as TweetDetailViewController
    tweetVC.networkController = self.networkController
    tweetVC.tweet = self.tweets[indexPath.row]
  
    self.navigationController?.pushViewController(tweetVC, animated: true)

  
  } // tableView(didDeselectRowAtIndexPath)

} // class ViewController


//
//  UserTimelineViewController.swift
//  MyTwitter
//
//  Created by John Leonard on 1/8/15.
//  Copyright (c) 2015 John Leonard. All rights reserved.
//

import UIKit

class UserTimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  var networkController: NetworkController!
  var userTweets = [Tweet]()
  //var userName: String!
  var screenName : String!
  
  
  @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
      
      // we're our own delegate and data source
      self.tableView.delegate = self
      self.tableView.dataSource = self
      
      // define the completion handler callback closure
      self.networkController.fetchUserTimeline(self.screenName) { (userTweets, errorString) -> () in
        if errorString == nil{ // everything's OK
          self.userTweets = userTweets!
          self.tableView.reloadData()
        } // if errorString
        else {
          // put in some kind of error handler here
        } // error
      } // networkController.fetchUserTimeline()
      
      // register the nib for the tweet table view cells
      self.tableView.registerNib(UINib(nibName: "CustomTweetCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "USER_TWEET_CELL")
    } // viewDidLoad()
  
  // how many rows are there?
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.userTweets.count
  } // tableView(numberOfRowsInSection)
  
  // what do we want to show?
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    // get the cell for this element of the tweets array
    let cell = tableView.dequeueReusableCellWithIdentifier("USER_TWEET_CELL", forIndexPath: indexPath) as CustomTweetCell
    
    // get he individual tweet
    let tweet = self.userTweets[indexPath.row]
    
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
} // userTimelineViewController

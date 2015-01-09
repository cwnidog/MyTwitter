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
      
      self.tableView.registerNib(UINib(nibName: "CustomTweetCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "USER_TWEET_CELL")
    } // viewDidLoad()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  // how many rows are there?
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.userTweets.count
  } // tableView(numberOfRowsInSection)
  
  // what do we want to show?
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    // get the cell for this element of the tweets array
    let cell = tableView.dequeueReusableCellWithIdentifier("USER_TWEET_CELL", forIndexPath: indexPath) as TweetCell
    
    // get he individual tweet
    let tweet = self.userTweets[indexPath.row]
    
    // display the tweet' user photo, name, and text
    // if the tweet has a user image associated with it, grab it
    if let imageURL = NSURL(string: tweet.imageURL) {
      if let imageData = NSData(contentsOfURL: imageURL){
        tweet.image = UIImage(data: imageData)
        cell.tweetImageView.image = tweet.image
      } // if let imageData
    } // if let imageURL
    
    cell.tweetLabel.text = tweet.text
    cell.nameLabel.text = tweet.userName
    return cell
  } // tableView(dequeueReusableCellWithIdentifier

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ViewController.swift
//  MyTwitter
//
//  Created by John Leonard on 1/5/15.
//  Copyright (c) 2015 John Leonard. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  var tweets = [Tweet]()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    var error: NSError? // holds a returned error from JSON serialization
    
    //get the path to the json data file
    if let jsonPath = NSBundle.mainBundle().pathForResource("tweet", ofType: "json") {
      // get the json data
      if let jsonData = NSData(contentsOfFile: jsonPath) {
        var error: NSError?
        
        //serialize the json data, so it can be interpreted
        if let jsonArray = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [AnyObject]{
          
          //get the dictionary elements from the array and append the individual tweets to the tweets list
          for object in jsonArray {
            if let jsonDictionary = object as? [String: AnyObject] {
              let tweet = Tweet(jsonDictionary)
              self.tweets.append(tweet)
            } // json Dictionary
            
          }// for each object
        } // json array
      } // json data
    } //jsonPath
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.dataSource = self
    println()
  } // viewDidLoad()

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.tweets.count
  } // tableView(numberOfRowsInSection)
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    // get the cell for this element of the tweets array
    let cell = tableView.dequeueReusableCellWithIdentifier("TWEET_CELL", forIndexPath: indexPath) as TweetCell
    
    // get he individual tweet
    let tweet = self.tweets[indexPath.row]
    
    // display the tweet text in the cell's label
    
    cell.tweetLabel.text = tweet.text
    cell.nameLabel.text = tweet.userName
    
    return cell
  }


}


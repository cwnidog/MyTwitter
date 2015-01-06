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

class ViewController: UIViewController, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  var tweets = [Tweet]()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // we're our own data source
    self.tableView.dataSource = self
    
    // get Twitter account type
    let accountStore = ACAccountStore()
    let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
    
    // request access to the Twitter account
    accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted, error) -> Void in
      
      // if we are able to get access to the account
      if granted {
        let accounts = accountStore.accountsWithAccountType(accountType)
        
        // if there are accounts, we want the first one in the list
        if !accounts.isEmpty{
          let twitterAccount = accounts.first as ACAccount
          
          // formuat and send the request for the account's tweets to twitter
          let requestURL = NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
          let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
          twitterRequest.account = twitterAccount
          
          //send the request
          twitterRequest.performRequestWithHandler(){ (jsonData, response, error) -> Void in
            
            // check responses status code, looking for anything in the 200s
            switch response.statusCode {
            case 200 ... 299: println("Got successfule response!")
            //serialize the json data, so it can be interpreted
            if let jsonArray = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: nil) as? [AnyObject]{
              
                //get the dictionary elements from the array and append the individual tweets to the tweets list
                for object in jsonArray {
                  if let jsonDictionary = object as? [String: AnyObject]{
                    let tweet = Tweet(jsonDictionary)
                    self.tweets.append(tweet)
                    
                    // put a request for teh tableView to reload its data on the main thread
                    NSOperationQueue.mainQueue().addOperationWithBlock(){ () -> Void in
                      self.tableView.reloadData()
                    } // NSOperationQueue closure
                  } // if let json Dictionary
                }// for each object
              } // if let json array
              
            case 400 ... 499: println("Got response saying error at our end")
            case 500 ... 599: println("Got response saying error at their end")
            default: println("Got response with unknown error \(response.statusCode)")
            } // switch status code
          } // send the request
        } // if accounts array isn't empty
      } // if granted
    } // accountStore closure
  } // override viewDidLoad()

  // how many rows are there?
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.tweets.count
  } // tableView(numberOfRowsInSection)
  
  // what do we want to show?
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    // get the cell for this element of the tweets array
    let cell = tableView.dequeueReusableCellWithIdentifier("TWEET_CELL", forIndexPath: indexPath) as TweetCell
    
    // get he individual tweet
    let tweet = self.tweets[indexPath.row]
    
    // display the tweet' user name and text
    cell.tweetLabel.text = tweet.text
    cell.nameLabel.text = tweet.userName
    
    return cell
  } // tableView(dequeueReusableCellWithIdentifier

} // class ViewController


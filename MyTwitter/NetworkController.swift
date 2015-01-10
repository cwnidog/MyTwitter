//
//  NetworkController.swift
//  MyTwitter
//
//  Created by John Leonard on 1/7/15.
//  Copyright (c) 2015 John Leonard. All rights reserved.
//

import Foundation
import Accounts
import Social

class NetworkController
{
  var twitterAccount: ACAccount?
  var imageQueue = NSOperationQueue()
  
  init()
  {
    // blank initializer keeps Xcode happy
  } // init()
  
  /*
      fetchHomeTimeline() gets the tweets in the user's Twitter home timeline and returns any
      found in an array of Tweet objects. If everything goes well, the error string is nil,
      else we include a text description of the error
  */
  
  func fetchHomeTimeline(completionHandler: ([Tweet]?, String?) -> ()) {
    
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
        self.twitterAccount = accounts.first as? ACAccount
        
        // format and send the request for the account's tweets to twitter
        let requestURL = NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
        let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
        twitterRequest.account = self.twitterAccount
        
        //send the request
          twitterRequest.performRequestWithHandler(){ (jsonData, response, error) -> Void in
          
          // check responses status code, looking for anything in the 200s
            switch response.statusCode {
            case 200 ... 299: println("Got successful response!")
            //serialize the json data, so it can be interpreted
            if let jsonArray = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: nil) as? [AnyObject]{
              
              var tweets = [Tweet]() // initialize an array to hold the tweets
            
            //get the dictionary elements from the array and append the individual tweets to the tweets array
              for object in jsonArray {
                if let jsonDictionary = object as? [String: AnyObject]{
                  let tweet = Tweet(jsonDictionary)
                  tweets.append(tweet)
                
                  // put a request for the tableView to reload its data on the main thread
                  NSOperationQueue.mainQueue().addOperationWithBlock(){ () -> Void in
                    completionHandler(tweets, nil)
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
  } // fetchHomeTimeline()
  
  func fetchTweetInfo(tweetId: String, completionHandler: ([String : AnyObject], String?) -> ()) {
    // format and send the GET request for the account's tweets to twitter.

    // construct the GET request URL using the selected tweet's id
    let requestURL = NSURL(string: "https://api.twitter.com/1.1/statuses/show.json?id=\(tweetId)")
    
    // construct the GET request using the request URL
    let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL!, parameters: nil)
    
    // specify the account we're using
    twitterRequest.account = self.twitterAccount // using same account as the original tweet
    
    //send the GET request
    twitterRequest.performRequestWithHandler(){ (jsonData, response, error) -> Void in
      
      //println(response) // just to check
      
      if error == nil {
        
        // check responses status code, looking for anything in the 200s
        switch response.statusCode {
          case 200 ... 299: println("Got successful response!")
          //serialize the json data, so it can be interpreted
          if let jsonDictionary = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: nil) as? [String: AnyObject]{
            
            // put a request for the view controller to reload its data on the main thread
            NSOperationQueue.mainQueue().addOperationWithBlock(){ () -> Void in
              completionHandler(jsonDictionary, nil)
            } // iNSOperationQueue closure
          } // if let jsonDictionary
          
          case 400 ... 499: println("Got response saying error at our end")
          case 500 ... 599: println("Got response saying error at their end")
          default: println("Got response with unknown error \(response.statusCode)")
        } // switch status code
      } // if error == nil

    } // send the request
  } // fetchTweetInfo()
  
  func fetchImageForTweet(tweet: Tweet, completionHandler: (UIImage?) -> ()) {
    
    if let imageURL = NSURL(string: tweet.imageURL) {
      self.imageQueue.addOperationWithBlock(){ () -> Void in
        if let imageData = NSData(contentsOfURL: imageURL) {
          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            tweet.image = UIImage(data: imageData)
            completionHandler(tweet.image)
          })
        } // if let imageData
      } // addOperationWithBlock
    } // if let imageURL
  } // fetchImageFoerTweet()
  
//  func fetchImageForURL(urlString: String, completionHandler: (UIImage?) -> ()) {
//    
//    println(urlString)
//    
//    if let imageURL = NSURL(string: urlString) {
//      self.imageQueue.addOperationWithBlock(){ () -> Void in
//        if let imageData = NSData(contentsOfURL: imageURL) {
//          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
//            let bannerImage = UIImage(data: imageData)
//            completionHandler(bannerImage)
//          })
//        } // if let imageData
//      } // addOperationWithBlock
//    } // if let imageURL
//  } // fetchImageFoerTweet()
  
  func fetchBannerForUser(userName: String, completionHandler: (UIImage, String?) -> ()) {
    // format and send the request for the account's tweets to twitter
    let requestURL = NSURL(string: "https://api.twitter.com/1.1/users/profile_banner.json?screen_name=\(userName)")
    println("This is the requested URL: \(requestURL!)")
    println("This is the User Name in fetchBannerForUser:\(userName)")
    let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
    twitterRequest.account = self.twitterAccount
    
    //send the request
    twitterRequest.performRequestWithHandler(){ (jsonData, response, error) -> Void in
      // if we didn't get an error back with the request, process the response
      if error == nil {
        // check responses status code, looking for anything in the 200s
        switch response.statusCode {
        case 200 ... 299: println("Got successful response!")
          //serialize the json data, so it can be interpreted
          if let jsonDictionary = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: nil) as? [String: AnyObject]{
    
            // put a request for the user timeline view controller to reload its data on the main thread
            let bannerDictionary = Banner(jsonDictionary)
            println("This is the banner URL: \(bannerDictionary.userBannerURL!)")
            if let imageURL = NSURL(string: bannerDictionary.userBannerURL!) {
              self.imageQueue.addOperationWithBlock(){ () -> Void in
                if let imageData = NSData(contentsOfURL: imageURL) {
                  
                  NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    let bannerImage = UIImage(data: imageData)
                    completionHandler(bannerImage!, nil)
                  })
                } // if let imageData
              } // addOperationWithBlock
            } // if let imageURL
          }
        case 400 ... 499: println("Got response saying error at our end")
        case 500 ... 599: println("Got response saying error at their end")
        default: println("Got response with unknown error \(response.statusCode)")
        } // switch status code
      } // if error == nil
    } // twitterRequest
   } // fetchBannerForTweet()
  
  
  func fetchUserTimeline(userName: String?, completionHandler: ([Tweet]?, String?) -> ()) {
    
    // format and send the request for the account's tweets to twitter
    let requestURL = NSURL(string: "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=\(userName!)")
    println("This is the User Name:\(userName!)")
    let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
    twitterRequest.account = self.twitterAccount
    
    //send the request
    twitterRequest.performRequestWithHandler(){ (jsonData, response, error) -> Void in
      
      // check responses status code, looking for anything in the 200s
      switch response.statusCode {
      case 200 ... 299: println("Got successful response!")
      //serialize the json data, so it can be interpreted
      if let jsonArray = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: nil) as? [AnyObject]{
        
        var tweets = [Tweet]() // initialize an array to hold the tweets
        
        //get the dictionary elements from the array and append the individual tweets to the tweets array
        for object in jsonArray {
          if let jsonDictionary = object as? [String: AnyObject]{
            let tweet = Tweet(jsonDictionary)
            tweets.append(tweet)
            
            // put a request for the tableView to reload its data on the main thread
            NSOperationQueue.mainQueue().addOperationWithBlock(){ () -> Void in
              completionHandler(tweets, nil)
            } // NSOperationQueue closure
          } // if let json Dictionary
        }// for each object
      } // if let json array
        
      case 400 ... 499: println("Got response saying error at our end")
      case 500 ... 599: println("Got response saying error at their end")
      default: println("Got response with unknown error \(response.statusCode)")
      } // switch status code
    } // send the request
  } // fetchUserTimeline()

} // NetworkController

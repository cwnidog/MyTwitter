//
//  tweet.swift
//  MyTwitter
//
//  Created by John Leonard on 1/5/15.
//  Copyright (c) 2015 John Leonard. All rights reserved.
//

import Foundation
import UIKit

class Tweet {
  var id: String
  var text: String
  var user: NSDictionary
  var userName: String
  var imageURL: String
  var image: UIImage?
  var favoriteCount: String?
  var screenName : String
  
  init( _ jsonDictionary: [String: AnyObject]) {
    self.id = jsonDictionary["id_str"] as String
    self.text = jsonDictionary["text"] as String // we can pull the text directly
    self.user = jsonDictionary["user"] as NSDictionary // get a handle on the user dictionary
    
    // pull needed fields from the user dictionary
    self.userName = user["name"] as String
    self.screenName = user["screen_name"] as String
    self.imageURL = user["profile_image_url"] as String
    
    if jsonDictionary["in_reply_to_user_id"] is NSNull {
      println("nsnul")
    } // if jsonDictionary

  } // init()
  
  func updateWithInfo(infoDictionary: [String: AnyObject]) {
    let favoriteNumber = infoDictionary["favorite_count"] as Int
    self.favoriteCount = "\(favoriteNumber)"
  } // updateWithInfo()
  
} // class Tweet

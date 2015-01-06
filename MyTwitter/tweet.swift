//
//  tweet.swift
//  MyTwitter
//
//  Created by John Leonard on 1/5/15.
//  Copyright (c) 2015 John Leonard. All rights reserved.
//

import Foundation

class Tweet {
  var text: String
  var user: NSDictionary
  var userName: String
  
  init( _ jsonDictionary: [String: AnyObject]) {
    self.text = jsonDictionary["text"] as String
    self.user = jsonDictionary["user"] as NSDictionary
    self.userName = user ["name"] as String
    
  }
}

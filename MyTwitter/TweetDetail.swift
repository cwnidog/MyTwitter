//
//  TweetDetail.swift
//  MyTwitter
//
//  Created by John Leonard on 1/7/15.
//  Copyright (c) 2015 John Leonard. All rights reserved.
//

import Foundation
import UIKit

class TweetDetail {
  var idString = ""
  var favoriteCount = 0
  var text = ""
  
  init( _ jsonDictionary: [String: AnyObject]) {
    self.idString = jsonDictionary["id_str"] as String
    self.text = jsonDictionary["text"] as String // we can pull the text directly
    self.favoriteCount = jsonDictionary["favorite_count"] as Int
  } //init()
} // TweetDetail

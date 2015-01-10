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
  var backgroundImageURL: String
  var textColor: UIColor!
  
  var profileTextColor: String // the text color is stored as a string representing an RGB hex value
  
  
  /*
    The tweet keeps the text color as an RGB hex value, which needs to be converted to a UIColor.
    I lifted a function to perform the conversion from Anthony/Blog:
    http://www.anthonydamota.me/blog/en/use-a-hex-color-code-with-uicolor-on-swift/
  */
  func UIColorFromRGB(colorCode: String, alpha: Float = 1.0) -> UIColor {
    var scanner = NSScanner(string:colorCode)
    var color:UInt32 = 0;
    scanner.scanHexInt(&color)
    
    let mask = 0x000000FF
    let r = CGFloat(Float(Int(color >> 16) & mask)/255.0)
    let g = CGFloat(Float(Int(color >> 8) & mask)/255.0)
    let b = CGFloat(Float(Int(color) & mask)/255.0)
    
    return UIColor(red: r, green: g, blue: b, alpha: CGFloat(alpha))
  } // UIColorFrom RGB
  
  init( _ jsonDictionary: [String: AnyObject]) {
    self.id = jsonDictionary["id_str"] as String
    self.text = jsonDictionary["text"] as String // we can pull the text directly
    self.user = jsonDictionary["user"] as NSDictionary // get a handle on the user dictionary
    
    // pull needed fields from the user dictionary
    self.userName = user["name"] as String
    self.screenName = user["screen_name"] as String
    self.imageURL = user["profile_image_url"] as String
    self.backgroundImageURL = user["profile_background_image_url_https"] as String
    
    // get the text color
    self.profileTextColor = user["profile_text_color"] as String
    self.textColor = UIColorFromRGB(self.profileTextColor, alpha: 1.0)
    
    if jsonDictionary["in_reply_to_user_id"] is NSNull {
      println("nsnul")
    } // if jsonDictionary

  } // init()
  
  func updateWithInfo(infoDictionary: [String: AnyObject]) {
    let favoriteNumber = infoDictionary["favorite_count"] as Int
    self.favoriteCount = "\(favoriteNumber)"
  } // updateWithInfo()
  
} // class Tweet

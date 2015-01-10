//
//  Banner.swift
//  MyTwitter
//
//  Created by John Leonard on 1/9/15.
//  Copyright (c) 2015 John Leonard. All rights reserved.
//

import Foundation
import UIKit

class Banner {
  var userBannerURL: String?
  var bannerSizes: NSDictionary
  var bannerType: NSDictionary
  
  init( _ jsonDictionary: [String : AnyObject]) {
    self.bannerSizes = jsonDictionary["sizes"] as NSDictionary
    self.bannerType = self.bannerSizes["mobile"] as NSDictionary
    self.userBannerURL = self.bannerType["url"] as? String
  } // init()
} // Banner

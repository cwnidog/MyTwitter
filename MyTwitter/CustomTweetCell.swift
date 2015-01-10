//
//  CustomTweetCell.swift
//  MyTwitter
//
//  Created by John Leonard on 1/8/15.
//  Copyright (c) 2015 John Leonard. All rights reserved.
//

import Foundation
import UIKit

class CustomTweetCell: UITableViewCell {
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var tweetLabel: UILabel!
  @IBOutlet weak var userImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  } // awakeFromNib()
  
  // prevent automatic height issue
  override func layoutSubviews() {
    super.layoutSubviews()
    self.contentView.layoutIfNeeded()
    self.tweetLabel.preferredMaxLayoutWidth = self.tweetLabel.frame.width
  } // layoutSubviews()
  
} // CustomTweetCell

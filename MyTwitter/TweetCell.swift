//
//  TweetCell.swift
//  MyTwitter
//
//  Created by John Leonard on 1/5/15.
//  Copyright (c) 2015 John Leonard. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

  @IBOutlet weak var tweetImageView: UIImageView!
  
  @IBOutlet weak var nameLabel: UILabel!
  
  @IBOutlet weak var tweetLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

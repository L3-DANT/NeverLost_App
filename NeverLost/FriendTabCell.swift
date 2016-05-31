//
//  ContactTableViewCell.swift
//  NeverLost
//
//  Created by El hadj on 27/05/2016.
//  Copyright © 2016 Milan Antonijevic. All rights reserved.
//

import UIKit

class FriendTabCell: UITableViewCell {

    //@IBOutlet var labelFriendUserName: UILabel!
  
    
    @IBOutlet var labelFriendEmail: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

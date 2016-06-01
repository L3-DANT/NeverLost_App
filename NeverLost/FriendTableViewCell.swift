//
//  FriendTableViewCell.swift
//  NeverLost
//
//  Created by Milan Antonijevic on 01/06/2016.
//  Copyright © 2016 Milan Antonijevic. All rights reserved.
//

import UIKit
import Foundation

class FriendTableViewCell : UITableViewCell {
    @IBOutlet weak var friendCellUsername: UILabel!
    @IBOutlet weak var friendCellLastSync: UILabel!
    @IBOutlet weak var friendCellEmail: UILabel!
    
    @IBAction func buttonShowOnMap(sender: UIButton) {
        print("Center on " + friendCellEmail!.text!)
    }
    
    @IBAction func buttonDeleteFriend(sender: UIButton) {
        print("Delete " + friendCellEmail!.text!)
    }
}
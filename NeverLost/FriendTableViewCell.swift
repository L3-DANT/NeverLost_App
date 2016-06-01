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
        NSNotificationCenter.defaultCenter().postNotificationName("centerOnHim", object: self.friendCellEmail.text!)
    }
    
    @IBAction func buttonDeleteFriend(sender: UIButton) {
        deleteFriend()
    }
    
    private func deleteFriend() -> Void {
        let parameters = getCheckOutParameters()
        let route = "services/deletefriend/" + friendCellEmail.text!
        
        sendRequestObject(route, parameters: parameters) { (code: Int, result: NSDictionary?) in
            dispatch_async(dispatch_get_main_queue(), {
                if code == 200 {
                    NSNotificationCenter.defaultCenter().postNotificationName("deleteFriend", object: self.friendCellEmail.text!)
                } else {
                    print("Error -> \(result!["error"])")
                }
            })
        }
    }
}
//
//  FriendsController.swift
//  NeverLost
//
//  Created by Milan Antonijevic on 31/05/2016.
//  Copyright © 2016 Milan Antonijevic. All rights reserved.
//

import UIKit
import Foundation

class FriendsController : UITableViewController {
    var friends = Global.getFriends()
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FriendsCell", forIndexPath: indexPath)
        
        let friend = friends[indexPath.row] as Contact
        cell.textLabel?.text = friend.username
        cell.detailTextLabel?.text = friend.email
        return cell
    }
}
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
    var contact: Contact? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PusherService.initTable(self.tableView, tabBar: tabBarItem)
        contact = nil
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FriendsController.centerOnHim(_:)),name:"centerOnHim", object:nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FriendsController.refresh(_:)),name:"deleteFriend", object:nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "FriendsToMap" {
            let mapController = segue.destinationViewController as! MapController
            mapController.focusLatitude = contact!.coordinate.latitude
            mapController.focusLongitude = contact!.coordinate.longitude
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Global.getFriends().count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FriendsCell", forIndexPath: indexPath) as! FriendTableViewCell
            
        let friend = Global.getFriends()[indexPath.row] as Contact
        cell.friendCellUsername!.text = friend.username
        cell.friendCellEmail!.text = friend.email
        cell.friendCellLastSync!.text = friend.lastSync.shortDate
        
        return cell
    }
    
    @objc private func centerOnHim(notification: NSNotification) -> Void {
        let email = notification.object as! String
        contact = Global.getContact(email)
        self.performSegueWithIdentifier("FriendsToMap", sender: self)
    }
    
    @objc func refresh(notification: NSNotification) -> Void {
        let email = notification.object as! String
        PusherService.removeFriend(email)
        Global.removeContact(email)
        
        let nb = Global.getFriends().count
        if nb > 0 {
            tabBarItem.badgeValue = String(nb)
        } else {
            tabBarItem.badgeValue = ""
        }
        
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })
    }
}
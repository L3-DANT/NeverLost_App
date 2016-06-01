//
//  IncomingController.swift
//  NeverLost
//
//  Created by Milan Antonijevic on 31/05/2016.
//  Copyright © 2016 Milan Antonijevic. All rights reserved.
//

import UIKit
import Foundation

class IncomingController : UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PusherService.initTable(self.tableView, tabBar: tabBarItem)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(IncomingController.refresh(_:)),name:"confirmRequest", object:nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(IncomingController.refresh(_:)),name:"declineRequest", object:nil)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Global.getIncoming().count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("IncomingCell", forIndexPath: indexPath) as! IncomingTableViewCell
        
        let incoming = Global.getIncoming()[indexPath.row] as Contact
        cell.IncomingCellUsername!.text = incoming.username
        cell.IncomingCellEmail!.text = incoming.email
        
        return cell
    }
    
    @objc func refresh(notification: NSNotification) -> Void {
        let email = notification.object as! String
        
        if notification.name == "confirmRequest" {
            Global.confirmFriend(email)
        } else if notification.name == "declineRequest" {
            Global.removeContact(email)
        }
        
        let nb = Global.getIncoming().count
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
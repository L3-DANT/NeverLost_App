//
//  OutcomingController.swift
//  NeverLost
//
//  Created by Milan Antonijevic on 31/05/2016.
//  Copyright © 2016 Milan Antonijevic. All rights reserved.
//

import UIKit
import Foundation

class OutcomingController : UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PusherService.initTable(self.tableView, tabBar: tabBarItem)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(OutcomingController.refresh(_:)),name:"cancelRequest", object:nil)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Global.getOutcoming().count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("OutcomingCell", forIndexPath: indexPath) as! OutcomingTableViewCell
        
        let outcoming = Global.getOutcoming()[indexPath.row] as Contact
        cell.OutcomingCellEmail?.text = outcoming.email
        
        return cell
    }
    
    @objc func refresh(notification: NSNotification) -> Void {
        let email = notification.object as! String
        Global.removeContact(email)
        
        let nb = Global.getOutcoming().count
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
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
    var outcomings = Global.getOutcoming()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(OutcomingController.refresh(_:)),name:"cancelRequest", object:nil)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return outcomings.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("OutcomingCell", forIndexPath: indexPath) as! OutcomingTableViewCell
        
        let outcoming = outcomings[indexPath.row] as Contact
        cell.OutcomingCellEmail?.text = outcoming.email
        
        return cell
    }
    
    @objc private func refresh(notification: NSNotification) -> Void {
        let email = notification.object as! String
        Global.removeContact(email)
        outcomings = Global.getOutcoming()
        
        let nb = outcomings.count
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
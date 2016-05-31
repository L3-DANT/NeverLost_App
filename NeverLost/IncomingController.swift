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
    var incomings = Global.getIncoming()
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return incomings.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("IncomingCell", forIndexPath: indexPath)
        
        let incoming = incomings[indexPath.row] as Contact
        cell.textLabel?.text = incoming.username
        cell.detailTextLabel?.text = incoming.email
        return cell
    }
}
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
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return outcomings.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("OutcomingCell", forIndexPath: indexPath)
        
        let outcoming = outcomings[indexPath.row] as Contact
        cell.textLabel?.text = outcoming.username
        cell.detailTextLabel?.text = outcoming.email
        return cell
    }
}
//
//  IncomingController.swift
//  NeverLost
//
//  Created by El hadj on 29/05/2016.
//  Copyright © 2016 Milan Antonijevic. All rights reserved.
//

import UIKit

class IncomingController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Global.getIncoming().count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("incomingCell")
        let contact = Global.getIncoming()[indexPath.row]
        cell?.textLabel?.text = contact.getEmail()
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("ligne \(indexPath.row) selectionnée ")
    }


    

}

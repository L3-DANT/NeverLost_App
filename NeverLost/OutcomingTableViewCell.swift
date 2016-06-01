//
//  OutcomingTableViewCell.swift
//  NeverLost
//
//  Created by Milan Antonijevic on 01/06/2016.
//  Copyright © 2016 Milan Antonijevic. All rights reserved.
//

import UIKit
import Foundation

class OutcomingTableViewCell : UITableViewCell {
    @IBOutlet weak var OutcomingCellEmail: UILabel!
    
    @IBAction func buttonCancelRequest(sender: UIButton) {
        deleteRequest()
    }
    
    private func deleteRequest() -> Void {
        let parameters = getCheckOutParameters()
        let route = "services/deletefriend/" + OutcomingCellEmail.text!
        
        sendRequestObject(route, parameters: parameters) { (code: Int, result: NSDictionary?) in
            dispatch_async(dispatch_get_main_queue(), {
                if code == 200 {
                    NSNotificationCenter.defaultCenter().postNotificationName("cancelRequest", object: self.OutcomingCellEmail.text!)
                } else {
                    print("Error -> \(result!["error"])")
                }
            })
        }
    }
}
//
//  IncomingTableViewCell.swift
//  NeverLost
//
//  Created by Milan Antonijevic on 01/06/2016.
//  Copyright © 2016 Milan Antonijevic. All rights reserved.
//

import UIKit
import Foundation

class IncomingTableViewCell : UITableViewCell {
    @IBOutlet weak var IncomingCellUsername: UILabel!
    @IBOutlet weak var IncomingCellEmail: UILabel!
    
    @IBAction func buttonConfirmFriend(sender: UIButton) {
        confirmRequest()
    }
    
    @IBAction func buttonDeclineFriend(sender: UIButton) {
        declineRequest()
    }
    
    private func confirmRequest() -> Void {
        let parameters = getCheckOutParameters()
        let route = "services/confirmfriend/" + IncomingCellEmail.text!
        
        sendRequestObject(route, parameters: parameters) { (code: Int, result: NSDictionary?) in
            dispatch_async(dispatch_get_main_queue(), {
                if code == 200 {
                    NSNotificationCenter.defaultCenter().postNotificationName("confirmRequest", object: self.IncomingCellEmail.text!)
                } else {
                    print("Error -> \(result!["error"])")
                }
            })
        }
    }

    private func declineRequest() -> Void {
        let parameters = getCheckOutParameters()
        let route = "services/deletefriend/" + IncomingCellEmail.text!
        
        sendRequestObject(route, parameters: parameters) { (code: Int, result: NSDictionary?) in
            dispatch_async(dispatch_get_main_queue(), {
                if code == 200 {
                    NSNotificationCenter.defaultCenter().postNotificationName("declineRequest", object: self.IncomingCellEmail.text!)
                } else {
                    print("Error -> \(result!["error"])")
                }
            })
        }
    }
}
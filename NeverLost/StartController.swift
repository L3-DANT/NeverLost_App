//
//  StartController.swift
//  NeverLost
//
//  Created by Milan Antonijevic on 14/05/2016.
//  Copyright © 2016 Milan Antonijevic. All rights reserved.
//

import UIKit
import Foundation

class StartController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let infos = getUserData()
        let email = infos.email
        let token = infos.token
        
        if email != nil && token != nil {
            //getContacts(email, token: token)
            self.performSegueWithIdentifier("StartToMap", sender: self)
        } else {
            self.performSegueWithIdentifier("StartToLogin", sender: self)
        }
    }
    
    private func getContacts() -> Void {
        let parameters = getCheckOutParameters()
        let route = "services/getfriendlist"
        
        callUrlWithData(route, parameters: parameters) { (code: Int, result: NSDictionary?) in
            if code == 200 && result != nil {
                //let contacts: Set<Contact> = Set<Contact>()
                
                
                
                
                Global.setContacts(Global.getContacts())
                self.performSegueWithIdentifier("StartToMap", sender: self)
            } else {
                self.showAlert("Das ist eine problem")
            }
        }
    }
}

//
//  StartController.swift
//  NeverLost
//
//  Created by Milan Antonijevic on 14/05/2016.
//  Copyright © 2016 Milan Antonijevic. All rights reserved.
//

import UIKit
import CoreLocation
import Foundation

class StartController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let infos = getUserData()
        let email = infos.email
        let token = infos.token
        
        if email != nil && token != nil {
            getContacts()
        } else {
            self.performSegueWithIdentifier("StartToLogin", sender: self)
        }
    }
    
    private func getContacts() -> Void {
        let parameters = getCheckOutParameters()
        let route = "services/getfriendlist"
        
        sendRequestArray(route, parameters: parameters) { (code: Int, result: [NSDictionary]) in
            dispatch_async(dispatch_get_main_queue(), {
                if code == 200 {
                    for item: NSDictionary in result {
                        let email = item["email"] as? String
                        let username = item["username"] as? String
                        //let status = result![cpt]![""] as? String
                        let longitude = item["lon"] as? CLLocationDegrees
                        let latitude = item["lat"] as? CLLocationDegrees
                        
                        let contact = Contact(email: email!, status: 0, username: username!, longitude: longitude!, latitude: latitude!)
                        
                        Global.addContact(contact)
                    }
                    
//                    for item in Global.getContacts() {
//                        print("CONTACT")
//                        print("email     -> " + item.getEmail())
//                        print("status    -> " + String(item.getStatus()))
//                        print("username  -> " + item.getUsername())
//                        print("longitude -> " + item.getLongitude().description)
//                        print("latitude  -> " + item.getLatitude().description)
//                    }
                    self.performSegueWithIdentifier("StartToMap", sender: self)
                } else {
                    self.showAlert(result.first!["error"]! as! String, button: "Se connecter", action: "StartToLogin")
                }
            })
        }
    }
}
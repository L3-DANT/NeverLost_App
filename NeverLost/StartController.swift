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
        
        callUrlWithData(route, parameters: parameters) { (code: Int, result: NSDictionary?) in
            if code == 200 && result != nil {
                for cpt in 0...result!.count {
                    let email = result![cpt]!["email"] as? String
                    let username = result![cpt]!["username"] as? String
                    //let status = result![cpt]![""] as? String
                    let longitude = result![cpt]!["lon"] as? CLLocationDegrees
                    let latitude = result![cpt]!["lat"] as? CLLocationDegrees
                    
                    let contact = Contact(email: email!, status: 0, username: username!, longitude: longitude!, latitude: latitude!)
                    
                    Global.addContact(contact)
                }
                
                for item in Global.getContacts() {
                    print("CONTACT")
                    print("email     -> " + item.getEmail())
                    print("status    -> " + String(item.getStatus()))
                    print("username  -> " + item.getUsername())
                    print("longitude -> " + item.getLongitude().description)
                    print("latitude  -> " + item.getLatitude().description)
                }
                self.performSegueWithIdentifier("StartToMap", sender: self)
            } else {
                self.showAlert(result!["error"]! as! String, button: "Se connecter")
                self.performSegueWithIdentifier("StartToLogin", sender: self)
            }
        }
    }
    
    private func ReCommitDueToFalseDate() -> Void {}
}
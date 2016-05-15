//
//  MapController.swift
//  NeverLost
//
//  Created by Milan Antonijevic on 14/05/2016.
//  Copyright © 2016 Milan Antonijevic. All rights reserved.
//

import UIKit
import Foundation

class MapController : UIViewController {
    
    @IBAction func buttonLogout(sender: UIButton) {
        let infos = getUserData()
        let email = infos.email
        let token = infos.token
        
        logout(email!, token: token!)
    }
    
    private func logout(email: String, token: String) -> Void {
        let parameters = ["email": email, "token": token] as Dictionary<String, String>
        
        let route = "authentication/logout"
        
        callUrlWithData(route, parameters: parameters) { (json: NSDictionary?, message: NSString?) in
            if message != nil {
                print("Error -> \(message)")
                return
            }
            
            if json != nil {
                let status = Int(json!["status"] as! String)
                
                if status == 200 {
                    setUserData(nil, token: nil)
                    
                    self.performSegueWithIdentifier("MapToLogin", sender: self)
                }
                
            }
        }
    }
}
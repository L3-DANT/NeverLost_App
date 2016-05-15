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
        logout()
    }
    
    private func logout() -> Void {
        let infos = getUserData()
        let email = infos.email
        let token = infos.token
        
        let parameters = ["email": email!, "token": token!] as Dictionary<String, String>
        
        let route = "authentication/logout"
        
        callUrlWithData(route, parameters: parameters) { (code: Int, result: NSDictionary?) in
            if code == 200 {
                setUserData(nil, token: nil)
                self.performSegueWithIdentifier("MapToLogin", sender: self)
            } else {
                print("Error -> \(result!["error"])")
            }
        }
    }
}
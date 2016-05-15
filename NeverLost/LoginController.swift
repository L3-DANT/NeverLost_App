//
//  LoginController.swift
//  NeverLost
//
//  Created by Milan Antonijevic on 14/05/2016.
//  Copyright © 2016 Milan Antonijevic. All rights reserved.
//

import UIKit
import Foundation

class LoginController: UIViewController {
    
    @IBOutlet weak var fieldEmail: UITextField!
    @IBOutlet weak var fieldPassword: UITextField!
    
    @IBAction func buttonLogin(sender: UIButton) {
        if fieldEmail.text!.isEmpty {
            self.showAlert("L'email est obligatoire.")
        } else if fieldPassword.text!.isEmpty {
            self.showAlert("Le mot de passe est obligatoire.")
        } else {
//            login(loginField.text!, password: passwordField.text!)
            login("shamil@mail.com", password: "shamil")
        }
    }
    
    private func login(email: String, password: String) -> Void {
        let parameters = ["email": email, "password": password] as Dictionary<String, String>
        
        let route = "authentication/login"
        
        callUrlWithData(route, parameters: parameters) { (json: NSDictionary?, message: NSString?) in
            if message != nil {
                self.showAlert(String(message))
                return
            }
            
            if json != nil {
                let email = json!["email"]
                let token = json!["token"]
                
                setUserData(email, token: token)
                
                self.performSegueWithIdentifier("LoginToMap", sender: self)
            }
        }
    }
}

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
//        let email = fieldEmail.text!
//        let password = fieldPassword.text!
//        
//        if email.isEmpty {
//            self.showAlert("L'email est obligatoire.")
//            return
//        }
//        
//        if !checkEmail(email) {
//            self.showAlert("Veuillez rentrer une adresse email valide.")
//            return
//        }
//        
//        if password.isEmpty {
//            self.showAlert("Le mot de passe est obligatoire.")
//            return
//        }
        
        login("shamil@mail.com", password: "shamil")
    }
    
    private func login(email: String, password: String) -> Void {
        let parameters = ["email": email, "password": password] as Dictionary<String, String>
        let route = "authentication/login"
        
        callUrlWithData(route, parameters: parameters) { (code: Int, result: NSDictionary?) in
            if code == 200 && result != nil {
                let email = result!["email"]
                let token = result!["token"]
                setUserData(email, token: token)
                self.performSegueWithIdentifier("LoginToMap", sender: self)
            } else {
                self.showAlert("Champs incorrects")
            }
        }
    }
}

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
        let email = fieldEmail.text!
        let password = fieldPassword.text!
        
        if email.isEmpty {
            setUserData("leo@mail.com", token: "3c4f398f-e322-47b3-bfeb-77bff775981b")
            self.showAlert("L'email est obligatoire.", button: "Ok")
        } else if !checkEmail(email) {
            self.showAlert("Veuillez rentrer une adresse email valide.", button: "Ok")
        } else if password.isEmpty {
            self.showAlert("Le mot de passe est obligatoire.", button: "Ok")
        } else {
            login(email, password: password)
        }
    }
    
    private func login(email: String, password: String) -> Void {
        let parameters = ["email": email, "password": password] as Dictionary<String, String>
        let route = "authentication/login"
        
        sendRequestObject(route, parameters: parameters) { (code: Int, result: NSDictionary?) in
            dispatch_async(dispatch_get_main_queue(), {
                if code == 200 {
                    let email = result!["email"]
                    let token = result!["token"]
                    setUserData(email, token: token)
                    self.performSegueWithIdentifier("LoginToMap", sender: self)
                } else {
                    self.showAlert("Champs incorrects", button: "Retour")
                }
            })
        }
    }
}

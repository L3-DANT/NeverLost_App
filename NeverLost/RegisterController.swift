//
//  RegisterController.swift
//  NeverLost
//
//  Created by Milan Antonijevic on 14/05/2016.
//  Copyright © 2016 Milan Antonijevic. All rights reserved.
//

import UIKit
import Foundation

class RegisterController: UIViewController {
    var registerEmail = ""
    var registerPassword = ""
    
    @IBOutlet weak var fieldEmail: UITextField!
    @IBOutlet weak var fieldPassword: UITextField!
    @IBOutlet weak var fieldConfirmation: UITextField!
    
    @IBAction func buttonRegister(sender: UIButton) {
        if fieldEmail.text!.isEmpty {
            self.showAlert("Attention", message: "L'email est obligatoire.", button: "Ok")
        } else if fieldPassword.text!.isEmpty {
            self.showAlert("Attention", message: "Le mot de passe est obligatoire.", button: "Ok")
        } else if fieldConfirmation.text! != fieldPassword.text! {
            self.showAlert("Attention", message: "Les champs de mot de passe ne correspondent pas.", button: "Ok")
        } else {
            register(fieldEmail.text!, password: fieldPassword.text!)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "RegisterToLogin" {
            let loginController = segue.destinationViewController as! LoginController
            loginController.loginEmail = registerEmail
            loginController.loginPassword = registerPassword
        }
    }
    
    private func register(email: String, password: String) -> Void {
        let parameters = ["email": email, "password": password] as Dictionary<String, String>
        let route = "services/createuser"
        
        sendRequestObject(route, parameters: parameters) { (code: Int, result: NSDictionary?) in
            dispatch_async(dispatch_get_main_queue(), {
                if code == 200 {
                    self.registerEmail = email
                    self.registerPassword = password
                    
                    self.showAlert("Inscription", message: "Un email vous a été envoyé.", button: "Ok", action: "RegisterToLogin")
                } else {
                    self.showAlert("Attention", message: "Cet adresse email est déjà utilisée.", button: "Retour")
                }
            })
        }
    }
}
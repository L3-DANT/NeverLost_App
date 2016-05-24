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
    
    @IBOutlet weak var fieldEmail: UITextField!
    @IBOutlet weak var fieldPassword: UITextField!
    @IBOutlet weak var fieldConfirmation: UITextField!

    @IBAction func buttonRegister(sender: UIButton) {
        if fieldEmail.text!.isEmpty {
            self.showAlert("L'email est obligatoire.", button: "Ok")
        } else if fieldPassword.text!.isEmpty {
            self.showAlert("Le mot de passe est obligatoire.", button: "Ok")
        } else if fieldConfirmation.text! != fieldPassword.text! {
            self.showAlert("Les champs de mot de passe ne correspondent pas.", button: "Ok")
        } else {
            register(fieldEmail.text!, password: fieldPassword.text!)
        }
    }
    
    private func register(email: String, password: String) -> Void {
        let parameters = ["email": email, "password": password] as Dictionary<String, String>
        let route = "services/createuser"
        
        sendRequestObject(route, parameters: parameters) { (code: Int, result: NSDictionary?) in
            if code == 200 {
                let email = result!["email"]
                let token = result!["token"]
                setUserData(email, token: token)
                Global.resetContacts()
                self.performSegueWithIdentifier("RegisterToMap", sender: self)
            } else {
                self.showAlert("Cet adresse email est déjà utilisée.", button: "Retour")
            }
        }
    }
}
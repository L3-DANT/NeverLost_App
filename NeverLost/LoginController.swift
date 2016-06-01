//
//  LoginController.swift
//  NeverLost
//
//  Created by Milan Antonijevic on 14/05/2016.
//  Copyright © 2016 Milan Antonijevic. All rights reserved.
//

import UIKit
import CoreLocation
import Foundation

class LoginController: UIViewController {
    var loginEmail = ""
    var loginPassword = ""
    
    @IBOutlet weak var fieldEmail: UITextField!
    @IBOutlet weak var fieldPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideBackButton()
        
        fieldEmail.text = loginEmail
        fieldPassword.text = loginPassword
    }
    
    @IBAction func buttonLogin(sender: UIButton) {
        let email = fieldEmail.text!
        let password = fieldPassword.text!
        
        if email.isEmpty {
            self.showAlert("Attention", message: "L'email est obligatoire.", button: "Ok")
        } else if !checkEmail(email) {
            self.showAlert("Attention", message: "Veuillez rentrer une adresse email valide.", button: "Ok")
        } else if password.isEmpty {
            self.showAlert("Attention", message: "Le mot de passe est obligatoire.", button: "Ok")
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
                    self.getContacts()
                } else if code == 403 {
                    self.showAlert("Attention", message: "Vous n'avez pas encore validé votre compte.", button: "Retour")
                } else {
                    self.showAlert("Attention", message: "Champs incorrects", button: "Retour")
                }
            })
        }
    }
    
    private func getContacts() -> Void {
        let parameters = getCheckOutParameters()
        let route = "services/getfriendlist"
        
        sendRequestArray(route, parameters: parameters) { (code: Int, result: [NSDictionary]) in
            dispatch_async(dispatch_get_main_queue(), {
                if code == 200 {
                    for item: NSDictionary in result {
                        let contact = JsonToContact(item)
                        Global.addContact(contact)
                    }
                    
                    PusherService.start()
                    
                    self.performSegueWithIdentifier("LoginToMap", sender: self)
                } else {
                    self.showAlert("Attention", message: result.first!["error"]! as! String, button: "Retour")
                }
            })
        }
    }
}

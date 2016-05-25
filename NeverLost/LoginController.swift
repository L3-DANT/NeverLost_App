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
    
    @IBOutlet weak var fieldEmail: UITextField!
    
    @IBOutlet weak var fieldPassword: UITextField!
    
    @IBAction func buttonLogin(sender: UIButton) {
        let email = fieldEmail.text!
        let password = fieldPassword.text!
        
        if email.isEmpty {
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
                    self.getContacts()
                } else {
                    self.showAlert("Champs incorrects", button: "Retour")
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
                        let email = item["email"] as? String
                        let username = item["username"] as? String
                        let status = item["confirmed"] as? Int
                        let longitude = item["lon"] as? CLLocationDegrees
                        let latitude = item["lat"] as? CLLocationDegrees
                        
                        let contact = Contact(email: email!, status: status!, username: username!, longitude: longitude!, latitude: latitude!)
                        
                        Global.addContact(contact)
                    }
                    
                    self.performSegueWithIdentifier("LoginToMap", sender: self)
                } else {
                    self.showAlert(result.first!["error"]! as! String, button: "Retour")
                }
            })
        }
    }
}

//
//  ProfileController.swift
//  NeverLost
//
//  Created by Milan Antonijevic on 01/06/2016.
//  Copyright © 2016 Milan Antonijevic. All rights reserved.
//

import UIKit
import Foundation

class ProfileController: UIViewController {
    
    var profileEmail = ""
    var profileUsername = ""
    var profileLastSync = ""
    
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var fieldUsername: UITextField!
    @IBOutlet weak var fieldPassword: UITextField!
    @IBOutlet weak var fieldConfirmation: UITextField!
    @IBOutlet weak var labelLastSync: UILabel!
    
    @IBAction func buttonCancel(sender: UIButton) {
        fieldUsername.text = profileUsername
        fieldPassword.text = ""
        fieldConfirmation.text = ""
    }
    
    @IBAction func buttonUpdate(sender: UIButton) {
        if fieldUsername.text!.isEmpty {
            self.showAlert("Le username est obligatoire.", button: "Ok")
        } else if fieldConfirmation.text! != fieldPassword.text! {
            self.showAlert("Les champs de mot de passe ne correspondent pas.", button: "Ok")
        } else if !(fieldUsername.text! == profileEmail && fieldPassword.text!.isEmpty) {
            update(fieldUsername.text!, password: fieldPassword.text!)
        }
    }
    
    @IBAction func buttonDelete(sender: UIButton) {
        delete()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        labelEmail.text = profileEmail
        fieldUsername.text = profileUsername
        labelLastSync.text = profileLastSync
    }
    
    private func update(username: String, password: String) -> Void {
        let infos = getUserData()
        var parameters: Dictionary<String, String>
        if password.isEmpty {
            parameters = ["email" : infos.email!, "token" : infos.token!, "username" : username] as Dictionary<String, String>
        } else {
            parameters = ["email" : infos.email!, "token" : infos.token!, "username" : username, "password" : password] as Dictionary<String, String>
        }
        
        let route = "services/updateuser"
        
        sendRequestObject(route, parameters: parameters) { (code: Int, result: NSDictionary?) in
            dispatch_async(dispatch_get_main_queue(), {
                if code == 200 {
                    self.showAlert("Vos informations ont bien été modifiées", button: "Ok")
                    self.profileUsername = username
                    self.fieldPassword.text = ""
                    self.fieldConfirmation.text = ""
                } else {
                    print("Error -> \(result!["error"])")
                }
            })
        }
    }
    
    private func delete() -> Void {
        let parameters = getCheckOutParameters()
        let route = "services/deleteuser"
        
        sendRequestObject(route, parameters: parameters) { (code: Int, result: NSDictionary?) in
            dispatch_async(dispatch_get_main_queue(), {
                if code == 200 {
                    setUserData(nil, token: nil)
                    Global.resetContacts()
                    PusherService.stop()
                    
                    self.performSegueWithIdentifier("ProfileToLogin", sender: self)
                } else {
                    print("Error -> \(result!["error"])")
                }
            })
        }
    }
}
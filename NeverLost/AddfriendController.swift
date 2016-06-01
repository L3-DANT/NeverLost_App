//
//  AddFriendController.swift
//  NeverLost
//
//  Created by Milan Antonijevic on 01/06/2016.
//  Copyright © 2016 Milan Antonijevic. All rights reserved.
//

import UIKit
import MapKit
import Foundation

class AddFriendController : UIViewController {
    @IBOutlet weak var fieldAddFriend: UITextField!
    
    @IBAction func buttonAddFriend(sender: UIButton) {
        let email = fieldAddFriend.text!
        
        if email.isEmpty {
            self.showAlert("Attention", message: "L'email est obligatoire.", button: "Ok")
        } else if !checkEmail(email) {
            self.showAlert("Attention", message: "Veuillez rentrer une adresse email valide.", button: "Ok")
        } else {
            requestFriend(email)
        }
    }
    
    private func requestFriend(email: String) -> Void {
        let parameters = getCheckOutParameters()
        let route = "services/requestfriend/" + email
        
        sendRequestObject(route, parameters: parameters) { (code: Int, result: NSDictionary?) in
            dispatch_async(dispatch_get_main_queue(), {
                if code == 200 {
                    self.showAlert("Félicitation", message: "Votre demande a bien été envoyée.", button: "Ok")
                    Global.addContact(Contact(email: email, status: 0, username: "", coordinate: CLLocationCoordinate2DMake(0.0, 0.0), lastSync: NSDate()))
                    self.fieldAddFriend.text = ""
                } else {
                    self.showAlert("Impossible", message: "Aucun contact ne possède cette adresse email.", button: "Retour")
                }
            })
        }
    }
}

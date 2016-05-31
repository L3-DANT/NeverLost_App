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
    
    var email = ""
    var username = ""
    var lastSync = ""
    
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var fieldUsername: UITextField!
    @IBOutlet weak var fieldPassword: UITextField!
    @IBOutlet weak var fieldConfirmation: UITextField!
    @IBOutlet weak var labelLastSync: UILabel!
    
    @IBAction func buttonUpdate(sender: UIButton) {
    }
    
    @IBAction func buttonCancel(sender: UIButton) {
        fieldUsername.text = username
        fieldPassword.text = ""
        fieldConfirmation.text = ""
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        labelEmail.text = email
        fieldUsername.text = username
        labelLastSync.text = lastSync
    }
}
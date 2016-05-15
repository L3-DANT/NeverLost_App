//
//  StartController.swift
//  NeverLost
//
//  Created by Milan Antonijevic on 14/05/2016.
//  Copyright © 2016 Milan Antonijevic. All rights reserved.
//

import UIKit
import Foundation

class StartController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let infos = getUserData()
        let email = infos.email
        let token = infos.token
        
        if email != nil && token != nil {
            self.performSegueWithIdentifier("StartToMap", sender: self)
        } else {
            self.performSegueWithIdentifier("StartToLogin", sender: self)
        }
    }
}

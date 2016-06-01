//
//  Extension_UIViewController.swift
//  NeverLost
//
//  Created by Milan Antonijevic on 14/05/2016.
//  Copyright © 2016 Milan Antonijevic. All rights reserved.
//

import UIKit
import Foundation

extension UIViewController {
    func showAlert(title: String, message: String, button: String, action: String? = nil) -> Void {
        let alert = UIAlertController(title : title, message: message, preferredStyle:UIAlertControllerStyle.Alert)
        var buttonAction: UIAlertAction
        
        if action != nil {
            buttonAction = UIAlertAction(title: button, style: UIAlertActionStyle.Default) { UIAlertAction in
                self.performSegueWithIdentifier(action!, sender: self)
            }
        } else {
            buttonAction = UIAlertAction(title: button, style: UIAlertActionStyle.Default, handler: nil )
        }
        
        alert.addAction(buttonAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func hideBackButton() -> Void {
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: navigationController, action: nil)
        
        navigationItem.leftBarButtonItem = backButton
    }
}
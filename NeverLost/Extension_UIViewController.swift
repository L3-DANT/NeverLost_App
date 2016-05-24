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
    public func showAlert(message: String, button: String, action: String? = nil) {
        let alert = UIAlertController(title : "Attention", message: message, preferredStyle:UIAlertControllerStyle.Alert)
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
}
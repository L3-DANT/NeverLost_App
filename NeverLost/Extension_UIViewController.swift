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
    public func showAlert(message: String, button: String) {
        let alert = UIAlertController(title : "Attention", message: message, preferredStyle:UIAlertControllerStyle.Alert)
        
        let button = UIAlertAction(title: button, style: UIAlertActionStyle.Default, handler: nil )
        
        alert.addAction(button)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    private func ReCommitDueToFalseDate() -> Void {}
}
//
//  ContactsController.swift
//  NeverLost
//
//  Created by Milan Antonijevic on 01/06/2016.
//  Copyright © 2016 Milan Antonijevic. All rights reserved.
//

import UIKit
import Foundation

class ContactsController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBadges()
    }
    
    private func setBadges() -> Void {
        let nbFriends = Global.getFriends().count
        if nbFriends > 0 {
            tabBar.items![0].badgeValue = String(nbFriends)
        }
        
        let nbIncoming = Global.getIncoming().count
        if nbIncoming > 0 {
            tabBar.items![1].badgeValue = String(nbIncoming)
        }
        
        let nbOutcoming = Global.getOutcoming().count
        if nbOutcoming > 0 {
            tabBar.items![2].badgeValue = String(nbOutcoming)
        }
    }
}

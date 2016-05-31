//
//  ContactsController.swift
//  NeverLost
//
//  Created by El hadj on 26/05/2016.
//  Copyright © 2016 Milan Antonijevic. All rights reserved.
//

import Foundation
import UIKit

class ContactsController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBadges()
    }
    
    
    private func setBadges() -> Void {
        tabBar.items![0].badgeValue = String(Global.getFriends().count)
        tabBar.items![1].badgeValue = String(Global.getIncoming().count)
        tabBar.items![2].badgeValue = String(Global.getOutcoming().count)
    }
}
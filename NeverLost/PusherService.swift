//
//  PusherService.swift
//  NeverLost
//
//  Created by Milan Antonijevic on 29/05/2016.
//  Copyright © 2016 Milan Antonijevic. All rights reserved.
//

import PusherSwift
import Foundation

public class PusherService {
    private static let app_key: String = "badd279471eca66c0f77"
    
    public static func start() {
        let pusher = Pusher(
            key: app_key,
            options: [
                "autoReconnect": true,
                "encrypted": true
            ]
        )
        
        let infos = getUserData()
        let channel = pusher.subscribe(infos.email!)
        
        channel.bind("friendRequest", callback: { (data: AnyObject?) -> Void in
            print("message received: (data)")
        })
        
        channel.bind("friendConfirm", callback: { (data: AnyObject?) -> Void in
            print("message received: (data)")
        })
        
        channel.bind("updatePos", callback: { (data: AnyObject?) -> Void in
            let email = data!["email"] as? String
            
            let dateAsString = data!["date"] as? String
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            let lastSync = dateFormatter.dateFromString(dateAsString!)
            
            let longitude = (data!["lon"] as? NSString)!.doubleValue
            let latitude = (data!["lat"] as? NSString)!.doubleValue
            
            Global.setContact(email!, lastSync: lastSync!, longitude: longitude, latitude: latitude)
            
            //TODO: change location of contact on map
        })
        
        pusher.connect()
    }
}
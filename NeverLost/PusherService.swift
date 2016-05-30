//
//  PusherService.swift
//  NeverLost
//
//  Created by Milan Antonijevic on 29/05/2016.
//  Copyright © 2016 Milan Antonijevic. All rights reserved.
//

import PusherSwift
import BRYXBanner
import MapKit
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
            let email = data!["email"] as? String
            let username = data!["username"] as? String
            
            let longitude = (data!["lon"] as? NSString)!.doubleValue
            let latitude = (data!["lat"] as? NSString)!.doubleValue
            let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
            
            let dateAsString = data!["date"] as? String
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            let lastSync = dateFormatter.dateFromString(dateAsString!)
            
            let contact = Contact(email: email!, status: -1, username: username!, coordinate: coordinate, lastSync: lastSync!)
            
            Global.addContact(contact)
            
            let title = "Nouvelle demande"
            let subtitle = username! + " (" + email! + ") souhaite devenir votre ami"
            
            let banner = Banner(title: title, subtitle: subtitle, image: UIImage(named: "contacts"), backgroundColor: UIColor(red: 203.00/255.0, green: 186.0/255.0, blue: 27.0/255.0, alpha: 1.000))
            banner.dismissesOnTap = true
            banner.show(duration: 5.0)
        })
        
        channel.bind("friendConfirm", callback: { (data: AnyObject?) -> Void in
            let email = data!["email"] as? String
            let username = data!["username"] as? String
            
            let longitude = (data!["lon"] as? NSString)!.doubleValue
            let latitude = (data!["lat"] as? NSString)!.doubleValue
            let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
            
            let dateAsString = data!["date"] as? String
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            let lastSync = dateFormatter.dateFromString(dateAsString!)
            
            Global.confirmFriend(email!)
            Global.updatePosition(email!, coordinate: coordinate, lastSync: lastSync!)
            
            let title = "Confirmation"
            let subtitle = username! + " (" + email! + ") est maintenant votre ami"
            
            let banner = Banner(title: title, subtitle: subtitle, image: UIImage(named: "contacts"), backgroundColor: UIColor(red: 48.00/255.0, green: 174.0/255.0, blue: 51.5/255.0, alpha: 1.000))
            banner.dismissesOnTap = true
            banner.show(duration: 5.0)
        })
        
        channel.bind("updatePos", callback: { (data: AnyObject?) -> Void in
            let email = data!["email"] as? String
            
            let longitude = (data!["lon"] as? NSString)!.doubleValue
            let latitude = (data!["lat"] as? NSString)!.doubleValue
            let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
            
            let dateAsString = data!["date"] as? String
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            let lastSync = dateFormatter.dateFromString(dateAsString!)
            
            Global.updatePosition(email!, coordinate: coordinate, lastSync: lastSync!)
            
            //TODO: change location of contact on map
        })
        
        pusher.connect()
    }
}
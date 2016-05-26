//
//  MapController.swift
//  NeverLost
//
//  Created by Milan Antonijevic on 14/05/2016.
//  Copyright © 2016 Milan Antonijevic. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Foundation
import PusherSwift

class MapController : UIViewController, CLLocationManagerDelegate {
    var location = CLLocationManager()
    var currentLocation: CLLocation? = nil
    
    @IBOutlet weak var map: MKMapView!
    
    @IBAction func buttonLogout(sender: UIButton) {
        logout()
    }
    
    @IBAction func buttonCenterOnMe(sender: UIButton) {
        centerOnMe()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        currentLocation = CLLocation(latitude: map.userLocation.coordinate.latitude, longitude: map.userLocation.coordinate.longitude)
        
        centerOnMe()

        location.delegate = self
        location.requestWhenInUseAuthorization()
        location.desiredAccuracy = kCLLocationAccuracyBest
        location.startUpdatingLocation()
        
        let pusher = Pusher(
            key: "badd279471eca66c0f77",
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
            guard data != nil else {
                return
            }
            
            let email = data!["email"] as? String
            let lastSync = data!["date"] as? NSDate
            let longitude = data!["lon"] as? CLLocationDegrees
            let latitude = data!["lat"] as? CLLocationDegrees
            
            Global.setContact(email!, lastSync: lastSync!, longitude: longitude!, latitude: latitude!)
            
            //TODO: change location of contact on map
        })
        
        pusher.connect()
    }
    
    func locationManager(manager:CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newLocation = locations.last {
            let distance = currentLocation?.distanceFromLocation(newLocation)
            if distance > 5 {
                currentLocation = newLocation
                sendPosition()
            }
        }
    }
    
    private func centerOnMe() -> Void {
        let center = CLLocationCoordinate2D(latitude: map.userLocation.coordinate.latitude, longitude: map.userLocation.coordinate.longitude)
        let width = 1000.0
        let height = 1000.0
        let region = MKCoordinateRegionMakeWithDistance(center, width, height)
        map.setRegion(region, animated: true)
        map.setUserTrackingMode(MKUserTrackingMode.Follow, animated: true)
    }
    
    private func sendPosition() -> Void {
        let longitude: String = (currentLocation?.coordinate.longitude.description)!
        let latitude: String = (currentLocation?.coordinate.latitude.description)!
        let parameters = getCheckOutParameters()
        let route = "services/sendmypos/" + longitude + "/" + latitude
        
        sendRequestObject(route, parameters: parameters) { (code: Int, result: NSDictionary?) in
            if code != 200 {
                print("Error -> \(result!["error"])")
            }
        }
    }
    
    private func logout() -> Void {
        location.stopUpdatingLocation()
        
        let parameters = getCheckOutParameters()
        let route = "authentication/logout"
        
        sendRequestObject(route, parameters: parameters) { (code: Int, result: NSDictionary?) in
            if code == 200 {
                setUserData(nil, token: nil)
                Global.resetContacts()
                self.performSegueWithIdentifier("MapToLogin", sender: self)
            } else {
                print("Error -> \(result!["error"])")
            }
        }
    }
}
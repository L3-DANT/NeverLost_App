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
    }
    
    func locationManager(manager:CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newLocation = locations.last {
            let distance = currentLocation?.distanceFromLocation(newLocation)
            if distance > 10 {
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
        
        callUrlWithData(route, parameters: parameters) { (code: Int, result: NSDictionary?) in
            if code != 200 {
                print("Error -> \(result!["error"])")
            }
        }
    }
    
    private func logout() -> Void {
        location.stopUpdatingLocation()
        
        let parameters = getCheckOutParameters()
        let route = "authentication/logout"
        
        callUrlWithData(route, parameters: parameters) { (code: Int, result: NSDictionary?) in
            if code == 200 {
                setUserData(nil, token: nil)
                self.performSegueWithIdentifier("MapToLogin", sender: self)
            } else {
                print("Error -> \(result!["error"])")
            }
        }
    }
}
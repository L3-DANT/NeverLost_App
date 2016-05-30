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

class MapController : UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
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
        
        map.delegate = self
        
        currentLocation = CLLocation(latitude: map.userLocation.coordinate.latitude, longitude: map.userLocation.coordinate.longitude)
        
        centerOnMe()
        
        location.delegate = self
        location.requestWhenInUseAuthorization()
        location.desiredAccuracy = kCLLocationAccuracyBest
        location.startUpdatingLocation()
        
        showFriendsOnMap()
    }
    
    func locationManager(manager:CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newLocation = locations.last {
            let distance = currentLocation!.distanceFromLocation(newLocation)
            if distance > 5 {
                currentLocation = newLocation
                sendPosition()
            }
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKindOfClass(Pin.self) {
            let reuseIdentifier = String(annotation.subtitle)
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseIdentifier)
            
            if annotationView == nil {
                annotationView = PinView(annotation: annotation, reuseIdentifier: reuseIdentifier)
                annotationView!.canShowCallout = true
            } else {
                annotationView!.annotation = annotation
            }
            return annotationView
        } else {
            return nil
        }
    }
    
    private func centerOnMe() -> Void {
        let center = CLLocationCoordinate2D(latitude: map.userLocation.coordinate.latitude, longitude: map.userLocation.coordinate.longitude)
        let width = 1000.0
        let height = 1000.0
        let region = MKCoordinateRegionMakeWithDistance(center, width, height)
        map.setRegion(region, animated: true)
        map.setUserTrackingMode(MKUserTrackingMode.Follow, animated: true)

        let incoming = Global.getIncoming()
        let friends = Global.getFriends()
        let outcoming = Global.getOutcoming()
        map.addAnnotations(Global.getFriendsAnnotations())
    }
    
    private func showFriendsOnMap() -> Void {
        map.addAnnotations(Global.getFriendsAnnotations())
    }
    
    private func sendPosition() -> Void {
        let latitude: String = (currentLocation?.coordinate.latitude.description)!
        let longitude: String = (currentLocation?.coordinate.longitude.description)!
        
        let parameters = getCheckOutParameters()
        let route = "services/sendmypos/" + latitude + "/" + longitude
        
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
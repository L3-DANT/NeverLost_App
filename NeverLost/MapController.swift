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
    var myEmail = ""
    var myUsername = ""
    var myLastSync = ""
    
    @IBOutlet weak var map: MKMapView!
    
    @IBAction func buttonProfile(sender: UIButton) {
        getInfos()
    }
    
    @IBAction func buttonCenterOnMe(sender: UIButton) {
        centerOnMe()
    }
    
    @IBAction func buttonLogout(sender: UIButton) {
        logout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideBackButton()
        
        PusherService.initMap(map)
        
        map.delegate = self
        
        currentLocation = CLLocation(latitude: map.userLocation.coordinate.latitude, longitude: map.userLocation.coordinate.longitude)
        
        centerOnMe()
        
        location.delegate = self
        location.requestWhenInUseAuthorization()
        location.desiredAccuracy = kCLLocationAccuracyBest
        location.startUpdatingLocation()
        
        showFriendsOnMap()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "MapToProfile" {
            let profileController = segue.destinationViewController as! ProfileController
            profileController.profileEmail = myEmail
            profileController.profileUsername = myUsername
            profileController.profileLastSync = myLastSync
        }
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
        if annotation.isKindOfClass(Contact.self) {
            //            let reuseId = String(annotation.subtitle)
            let reuseId = "friendPin"
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
            
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
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
        
        map.addAnnotations(Global.getFriends())
    }
    
    private func showFriendsOnMap() -> Void {
        map.addAnnotations(Global.getFriends())
        
        for friend: Contact in Global.getFriends() {
            dispatch_async(dispatch_get_main_queue()) {
                self.map.addAnnotation(friend)
            }
        }
    }
    
    private func sendPosition() -> Void {
        let latitude: String = (currentLocation?.coordinate.latitude.description)!
        let longitude: String = (currentLocation?.coordinate.longitude.description)!
        
        let parameters = getCheckOutParameters()
        let route = "services/sendmypos/" + latitude + "/" + longitude
        
        sendRequestObject(route, parameters: parameters) { (code: Int, result: NSDictionary?) in
            dispatch_async(dispatch_get_main_queue(), {
                if code != 200 {
                    print("Error -> \(result!["error"])")
                }
            })
        }
    }
    
    private func getInfos() -> Void {
        let parameters = getCheckOutParameters()
        
        let infos = getUserData()
        let route = "services/findfriend/" + infos.email!
        
        sendRequestObject(route, parameters: parameters) { (code: Int, result: NSDictionary?) in
            dispatch_async(dispatch_get_main_queue(), {
                if code == 200 {
                    self.myEmail = (result!["email"] as? String)!
                    self.myUsername = (result!["username"] as? String)!
                    
                    let dateAsString = result!["date"] as? String
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "MMM d, yyyy HH:mm:ss a"
                    dateFormatter.timeZone = NSTimeZone(name: "GMT+2")
                    let lastSync = dateFormatter.dateFromString(dateAsString!)
                    self.myLastSync = lastSync!.shortDate
                    
                    self.performSegueWithIdentifier("MapToProfile", sender: self)
                } else {
                    print("Error -> \(result!["error"])")
                }
            })
        }
    }
    
    private func logout() -> Void {
        location.stopUpdatingLocation()
        
        let parameters = getCheckOutParameters()
        let route = "authentication/logout"
        
        sendRequestObject(route, parameters: parameters) { (code: Int, result: NSDictionary?) in
            dispatch_async(dispatch_get_main_queue(), {
                if code == 200 {
                    setUserData(nil, token: nil)
                    Global.resetContacts()
                    PusherService.stop()
                    
                    self.performSegueWithIdentifier("MapToLogin", sender: self)
                } else {
                    print("Error -> \(result!["error"])")
                }
            })
        }
    }
}
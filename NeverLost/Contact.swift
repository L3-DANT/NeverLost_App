//
//  Contact.swift
//  NeverLost
//
//  Created by El hadj on 21/05/2016.
//  Copyright © 2016 Milan Antonijevic. All rights reserved.
//

import CoreLocation
import MapKit
import Foundation

public class Contact : Hashable {
    private var email: String
    private var username : String
    private var status: Int
    private var lastSync: NSDate
    private var latitude: CLLocationDegrees
    private var longitude: CLLocationDegrees
    
    private var annotation: Pin
    
    public init(email: String, status: Int , username : String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        self.email = email
        self.username = username
        self.status = status
        //TODO: Get date from database
        self.lastSync = NSDate()
        self.latitude = latitude
        self.longitude = longitude
        
        annotation = Pin(coordinate: CLLocationCoordinate2DMake(latitude, longitude), title: username, subtitle: email)
//        updateAnnotation()
    }
    
    public func getEmail() -> String {
        return email
    }
    
    public func setEmail(email: String) -> Void {
        self.email = email
    }
    
    public func getUsername () -> String {
        return username
    }
    
    public func setUsername( username : String) -> Void {
        self.username = username
    }
    
    public func getStatus() -> Int {
        return status
    }
    
    public func setStatus(status: Int) -> Void {
        self.status = status
    }
    
    public func getLastSync() -> NSDate {
        return lastSync
    }
    
    public func setLastSync(lastSync: NSDate) -> Void {
        self.lastSync = lastSync
    }
    
    public func getLatitude() -> CLLocationDegrees {
        return latitude
    }
    
    public func setLatitude(latitude: CLLocationDegrees) -> Void {
        self.latitude = latitude
    }
    
    public func getLongitude() -> CLLocationDegrees {
        return longitude
    }
    
    public func setLongitude(longitude: CLLocationDegrees) -> Void {
        self.longitude = longitude
    }
    
    public func getAnnotation() -> Pin {
        return annotation
    }
    
    public func updateAnnotation() -> Void {
        annotation.title = self.username
        annotation.subtitle = self.email
        annotation.coordinate = CLLocationCoordinate2DMake(self.latitude, self.longitude)
    }
    
    public var hashValue : Int {
        get {
            return email.hashValue
        }
    }
}

public func == (lhs: Contact, rhs: Contact) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
//
//  Contact.swift
//  NeverLost
//
//  Created by El hadj on 21/05/2016.
//  Copyright © 2016 Milan Antonijevic. All rights reserved.
//

import CoreLocation
import Foundation

public class Contact : Hashable {
    private var email: String
    private var status: Int
    private var username : String
    private var longitude: CLLocationDegrees
    private var latitude: CLLocationDegrees
    
//    public init(email: String) {
//        self.email = email
//        status = -2
//        username = ""
//        longitude = CLLocationDegrees()
//        latitude = CLLocationDegrees()
//    }
    
    public init(email: String, status: Int , username : String, longitude: CLLocationDegrees, latitude: CLLocationDegrees) {
        self.email = email
        self.status = status
        self.username = username
        self.longitude = longitude
        self.latitude = latitude
    }
    
    public func getEmail() -> String {
        return email
    }
    
    public func setEmail(email: String) -> Void {
        self.email = email
    }
    
    public func getStatus() -> Int {
        return status
    }
    
    public func setStatus(status: Int) -> Void {
        self.status = status
    }
    
    public func getLongitude() -> CLLocationDegrees {
        return longitude
    }
    
    public func setLongitude(longitude: CLLocationDegrees) -> Void {
        self.longitude = longitude
    }
    
    public func getLatitude() -> CLLocationDegrees {
        return latitude
    }
    
    public func setLatitude(latitude: CLLocationDegrees) -> Void {
        self.latitude = latitude
    }
    
    public func getUsername () -> String {
        return username
    }
    
    public func setUsername( username : String) -> Void {
        self.username = username
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
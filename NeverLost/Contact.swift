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
    private var userName : String
    private var longitude: CLLocationDegrees?
    private var latitude: CLLocationDegrees?
    
    
    public init(email: String ) {
        self.email = email
        status = -2
        longitude = nil
        latitude = nil
    }
    
    public init(email: String, status: Int , userName : String) {
        self.email = email
        self.status = status
        self.userName = userName
        longitude = nil
        latitude = nil
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
    
    public func getLongitude() -> CLLocationDegrees? {
        return longitude
    }
    
    public func setLongitude(longitude: CLLocationDegrees?) -> Void {
        self.longitude = longitude
    }
    
    public func getLatitude() -> CLLocationDegrees? {
        return latitude
    }
    
    public func setLatitude(latitude: CLLocationDegrees?) -> Void {
        self.latitude = latitude
    }
    
    public func getUserName () -> String {
        return userName
    }
    
    public func setUserName( userName : String) -> Void {
        self.userName = userName
    }
    
    public var hashValue : Int {
        get {
            return "\(self.email)".hashValue
        }
    }
}

public func == (lhs: Contact, rhs: Contact) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
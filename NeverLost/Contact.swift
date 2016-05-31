//
//  Contact.swift
//  NeverLost
//
//  Created by El hadj on 21/05/2016.
//  Copyright © 2016 Milan Antonijevic. All rights reserved.
//

import MapKit
import Foundation

//class Contact : Hashable {
//    var email: String
//    var username : String
//    var status: Int
//    var lastSync: NSDate
//    var coordinate: CLLocationCoordinate2D
//    
//    init (email: String, status: Int , username : String, coordinate: CLLocationCoordinate2D, lastSync: NSDate) {
//        self.email = email
//        self.username = username
//        self.status = status
//        self.lastSync = lastSync
//        self.coordinate = coordinate
//    }
//    
//    var hashValue : Int {
//        get {
//            return email.hashValue
//        }
//    }
//}
//
//func == (lhs: Contact, rhs: Contact) -> Bool {
//    return lhs.hashValue == rhs.hashValue
//}

class Contact : NSObject, MKAnnotation {
    var email: String
    var username : String
    var status: Int
    var lastSync: NSDate
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init (email: String, status: Int , username : String, coordinate: CLLocationCoordinate2D, lastSync: NSDate) {
        self.email = email
        self.username = username
        self.status = status
        self.lastSync = lastSync
        self.coordinate = coordinate
        title = username
        subtitle = email
    }
    
    override var hashValue : Int {
        get {
            return email.hashValue
        }
    }
}

func == (lhs: Contact, rhs: Contact) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
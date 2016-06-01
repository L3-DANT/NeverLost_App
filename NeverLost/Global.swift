//
//  Global.swift
//  NeverLost
//
//  Created by El hadj on 21/05/2016.
//  Copyright © 2016 Milan Antonijevic. All rights reserved.
//

import MapKit
import Foundation

class Global {
    
    private static var contacts: Set<Contact> = Set<Contact>()
    
    static func getFriends() -> [Contact] {
        return contacts.filter({ $0.status == 1})
    }
    
    static func getIncoming() -> [Contact] {
        return contacts.filter({ $0.status == -1})
    }
    
    static func getOutcoming() -> [Contact] {
        return contacts.filter({ $0.status == 0})
    }
    
    static func addContact(contact: Contact) -> Void {
        contacts.insert(contact)
    }
    
    static func removeContact(email: String) -> Void {
        if let contact = getContact(email) {
            contacts.remove(contact)
        }
    }
    
    static func resetContacts() -> Void {
        contacts.removeAll()
    }
    
    static func getContact(email: String) -> Contact? {
        let tabFiltered = contacts.filter({ $0.email == email })
        
        if tabFiltered.isEmpty {
            return nil
        } else {
            return tabFiltered.first
        }
    }
    
    static func confirmFriend(email: String) -> Void {
        if let contact = getContact(email) {
            contact.status = 1
        } else {
            //TODO: set errors
        }
    }
    
    static func updateInfos(email: String, username: String) -> Void {
        if let contact = getContact(email) {
            contact.username = username
        } else {
            //TODO: set errors
        }
    }
    
    static func updatePosition(email: String, coordinate: CLLocationCoordinate2D, lastSync: NSDate) -> Void {
        if let contact = getContact(email) {
            contact.coordinate = coordinate
            contact.lastSync = lastSync
        } else {
            //TODO: set errors
        }
    }
    
//    static func getFriendsAnnotations() -> [Pin] {
//        var pins = [Pin]()
//        
//        for contact: Contact in getFriends() {
//            pins.append(Pin(coordinate: contact.coordinate, title: contact.username, subtitle: contact.email))
//        }
//        
//        return pins
//    }
    
//    static func getFriendsAnnotations() -> [MKPointAnnotation] {
//        var pins = [MKPointAnnotation]()
//        
//        for contact: Contact in getFriends() {
//            let pin = MKPointAnnotation()
//            pin.coordinate = contact.coordinate
//            pin.title = contact.username
//            pin.subtitle = contact.email
//            pins.append(pin)
//        }
//        
//        return pins
//    }
}
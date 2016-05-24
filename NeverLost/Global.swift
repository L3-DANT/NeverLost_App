//
//  Global.swift
//  NeverLost
//
//  Created by El hadj on 21/05/2016.
//  Copyright © 2016 Milan Antonijevic. All rights reserved.
//

import CoreLocation
import Foundation

public class Global {
    
    private static var contacts: Set<Contact> = Set<Contact>()
    
    public static func getContacts() -> Set<Contact> {
        return contacts
    }
    
    public static func setContacts(contacts: Set<Contact>) -> Void {
        self.contacts = contacts
    }
    
    public static func addContact(contact: Contact) -> Void {
        contacts.insert(contact)
    }
    
    public static func resetContacts() -> Void {
        contacts.removeAll()
    }
    
    public static func getContact(email: String) -> Contact? {
        let tabFiltered = contacts.filter({ $0.getEmail() == email })
        
        if tabFiltered.isEmpty {
            return nil
        } else {
            return tabFiltered.first
        }
    }
    
    public static func setContact(email: String, status: Int? = nil, username : String? = nil, longitude: CLLocationDegrees? = nil, latitude: CLLocationDegrees? = nil) -> Void {
        if let contact = getContact(email) {
            if status != nil {
                contact.setStatus(status!)
            }
            if username != nil {
                contact.setUsername(username!)
            }
            if longitude != nil {
                contact.setLongitude(longitude!)
            }
            if latitude != nil {
                contact.setLatitude(latitude!)
            }
        } else {
            
        }
    }
}
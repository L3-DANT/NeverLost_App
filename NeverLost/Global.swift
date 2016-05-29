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
    
    public static func setContact(email: String, username : String? = nil, status: Int? = nil, lastSync: NSDate? = nil, latitude: CLLocationDegrees? = nil, longitude: CLLocationDegrees? = nil) -> Void {
        if let contact = getContact(email) {
            if username != nil {
                contact.setUsername(username!)
            }
            
            if status != nil {
                contact.setStatus(status!)
            }
            
            if lastSync != nil {
                contact.setLastSync(lastSync!)
            }
                        
            if latitude != nil {
                contact.setLatitude(latitude!)
            }
            
            if longitude != nil {
                contact.setLongitude(longitude!)
            }
            
            contact.updateAnnotation()
        } else {
            
        }
    }
    
    public static func getAnnotations() -> [Pin] {
        var annotations = [Pin]()
        
        for contact: Contact in contacts {
            annotations.append(contact.getAnnotation())
        }
        
        return annotations
    }
}
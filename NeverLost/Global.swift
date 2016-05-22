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
    
    private static var contactsArray: [Contact] = []
    
    //    public static func getContacts() -> Set<Contact> {
    //        return contacts
    //    }
    //
    //    public static func setContacts(contacts: Set<Contact>) -> Void {
    //        self.contacts = contacts
    //    }
    
    public static func getContact(email: String) -> Contact? {
        
        if contacts.isEmpty {
            return nil
            
        } else {
            
            if contacts.contains({ $0.getEmail() == email }) {
                //return $0 // ça aurait étét parfait si on pouvait retourner $0
                
            } else {
                return nil
            }
        }
    }
    
    
    
//    public static func getContact1(email: String) -> Contact? {
//        
//        if contacts.isEmpty {
//            return nil
//        } else {
//            
//            var contactTemp : Set<Contact> = contacts
//            
//            var contact = contactTemp.filter({$0.getEmail() == email })
//            
//            return contact
//            
//        } else {
//            return nil
//        }
//    }
    
//    let predicateClosure = { (res : Contact) -> Bool in
//        
//        return res == contact
//        
//    }
//    
//    for contact in contacts where predicateClosure(contact) {
//    
//    return contact
//    }
//    
//}
//
//if contacts.contains({ $0.getEmail() == email }) {
//    return $0
    
    
    //        var yourItem:YourType!
    //        if contains(yourArray, item){
    //            yourItem = item
    //        }
    
    
}

//public static func setContact(email: String, status: Int? = nil, userName : String longitude: CLLocationDegrees? = nil, latitude: CLLocationDegrees? = nil) -> Void {
//    if let contact = getContact(email) {
//        if status != nil {
//            contact.setStatus(status!)
//        }
//        if longitude != nil {
//            contact.setLongitude(longitude!)
//        }
//        if latitude != nil {
//            contact.setLatitude(latitude!)
//        }
//    } else {
//        
//    }
//}




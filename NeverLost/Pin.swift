//
//  Pin.swift
//  NeverLost
//
//  Created by Milan Antonijevic on 29/05/2016.
//  Copyright © 2016 Milan Antonijevic. All rights reserved.
//

import UIKit
import MapKit
import Foundation

public class Pin : NSObject, MKAnnotation {
    
    public var coordinate:CLLocationCoordinate2D
    public var title:String?
    public var subtitle:String?
    public var numero:String?
    public var pinCustomImageName : String?
    
    public init(coordinate : CLLocationCoordinate2D, title : String?, subtitle : String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.pinCustomImageName = "customPin"
    }
}
//
//  Extension_CLLocation.swift
//  NeverLost
//
//  Created by Milan Antonijevic on 15/05/2016.
//  Copyright © 2016 Milan Antonijevic. All rights reserved.
//

import CoreLocation
import Foundation

extension CLLocation {
    public func getLongitude() -> String {
        return self.coordinate.longitude.description
    }
}
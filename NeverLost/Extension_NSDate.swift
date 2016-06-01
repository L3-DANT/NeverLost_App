//
//  Extension_NSDate.swift
//  NeverLost
//
//  Created by Milan Antonijevic on 01/06/2016.
//  Copyright © 2016 Milan Antonijevic. All rights reserved.
//

import Foundation

extension NSDate {
    struct Date {
        static let formatterShortDate = NSDateFormatter(dateFormat: "dd/MM/yyyy HH:mm")
    }
    
    var shortDate: String {
        return Date.formatterShortDate.stringFromDate(self)
    }
}

extension NSDateFormatter {
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}
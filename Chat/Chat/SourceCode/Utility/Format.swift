//
//  Format.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/8/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import Foundation

public let UTCTimeZone = TimeZone(secondsFromGMT: 0)!

public enum Format {
    //"yyyy-MM-dd'T'HH:mm:ssZZZZZ"
}

extension Formatter {
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
}

extension Date {
    fileprivate var chatTimeString: String {
        get {
            let calendar = Calendar.current
            let now = Date()
            let unit: NSCalendar.Unit = [
                NSCalendar.Unit.minute,
                NSCalendar.Unit.hour,
                NSCalendar.Unit.day,
                NSCalendar.Unit.month,
                NSCalendar.Unit.year,
                ]
            let nowComponents:DateComponents = (calendar as NSCalendar).components(unit, from: now)
            let targetComponents:DateComponents = (calendar as NSCalendar).components(unit, from: self)
            
            let year = nowComponents.year! - targetComponents.year!
            let month = nowComponents.month! - targetComponents.month!
            let day = nowComponents.day! - targetComponents.day!
            
            return ""
        }
        
    }
}

extension Date {
    var iso8601: String {
        return Formatter.iso8601.string(from: self)
    }
}

extension String {
    var dateFromISO8601: Date? {
        return Formatter.iso8601.date(from: self)
    }
}

extension Date {
    func isBetweeen(date date1: Date, andDate date2: Date) -> Bool {
        return date1.compare(self) == self.compare(date2)
    }
}

extension Date {
    func onlyDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    
    func toString(format:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

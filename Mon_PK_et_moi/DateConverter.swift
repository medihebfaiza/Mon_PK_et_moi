//
//  DateConverter.swift
//  Mon_PK_et_moi
//
//  Created by Mohamed-Iheb FAIZA on 24/03/2018.
//  Copyright © 2018 FAIZA&LECLER. All rights reserved.
//

import Foundation

class DateConverter {
    
    static func toHHmmss(date : NSDate ) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(for: date)
    }
    
    static func toHHmm(date : NSDate ) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(for: date)
    }
    
    static func toDDmmYYYY(date : NSDate ) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(for: date)
    }
    
    static func toString(date : NSDate ) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy hh:mm"
        return formatter.string(for: date)
    }
    
    static func nextDay(date : NSDate) -> NSDate {
        let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: date as Date)
        return nextDay! as NSDate
    }
    
    static func nextMonth(date : NSDate) -> NSDate {
        let nextDay = Calendar.current.date(byAdding: .day, value: 31, to: date as Date)
        return nextDay! as NSDate
    }
}

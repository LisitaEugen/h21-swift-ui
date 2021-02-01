//
//  Date.swift
//  H21
//
//  Created by Evgheni Lisita on 17.09.19.
//  Copyright © 2019 Evgheni Lisita. All rights reserved.
//

import Foundation

extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
    
    func before(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: -days, to: noon)!
    }
    
    static func getFormattedDate(date: Date, format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: date)
    }
    
    static func date(fromString string: String, withFormat format: String) -> Date? {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = format

        return dateformatter.date(from: string)
    }
    
    func short() -> String {
        return Date.getFormattedDate(date: self, format: "E d")
    }
    
    static var currentRangeDates: [Date] = {
        var numberOfDaysInRange = 6
        var currentDate = Date().before(days: numberOfDaysInRange - 1)
        var dates = [Date]()
        
        for index in 0...(numberOfDaysInRange - 1) {
            dates.append(currentDate)
            currentDate = currentDate.dayAfter
        }
        
        return dates
    }()
    
    static var currentTimeStamp: String {
        return String(Int64(Date().timeIntervalSince1970 * 1000))
    }
    
}
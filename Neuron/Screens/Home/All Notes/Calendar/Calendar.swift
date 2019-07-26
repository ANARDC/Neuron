//
//  Calendar.swift
//  Neuron
//
//  Created by Anar on 24/07/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import Foundation

final class NoteCalendar {
    static var offset = 0
    
    enum position {
        case previous
        case current
        case next
        func value() -> DateComponents {
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.M"
            let result = formatter.string(from: date)
            
            let year = Int(result.components(separatedBy: ".")[0])!
            let month = Int(result.components(separatedBy: ".")[1])!
            
            switch self {
            case .previous:
                NoteCalendar.offset -= 1
            case .current:
                return DateComponents(year: year, month: month)
            case .next:
                NoteCalendar.offset += 1
            }
            
            switch NoteCalendar.offset {
            case ..<0:
                let year = year - Int((12 - NoteCalendar.offset - month) / 12)
                let month = (month + NoteCalendar.offset - 1) % 12 + 1
                return DateComponents(year: year, month: month)
            case 0...:
                let year = year + Int((NoteCalendar.offset + month - 1) / 12)
                let month = (month + NoteCalendar.offset - 1) % 12 + 1
                return DateComponents(year: year, month: month)
            default:
                return DateComponents(year: year, month: month)
            }
        }
    }
    
    func getDateInfo(of position: position) -> MonthData {
        let dateComponents = position.value()
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        let range = calendar.range(of: .day, in: .month, for: date)!
        
        let year = String(dateComponents.year!)
        let index = (dateComponents.month! - 1) % 12 < 0 ? 12 + (dateComponents.month! - 1) % 12 : (dateComponents.month! - 1) % 12
        let month = DateFormatter().monthSymbols[index]
        let daysCount = range.count
        
        switch position {
        case .current:
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd"
            let result = formatter.string(from: date)
            let currentDay = Int(result)
            let currentDayNumberInWeek = currentDay! % 7 - 1
            return MonthData(year: year,
                             month: month,
                             daysCount: daysCount,
                             currentDayNumberInWeek: currentDayNumberInWeek,
                             currentDay: currentDay)
        default:
            return MonthData(year: year,
                             month: month,
                             daysCount: daysCount)
        }
    }
}

struct MonthData {
    var year: String
    var month: String
    var daysCount: Int
    var currentDayNumberInWeek: Int?
    var currentDay: Int?
}

extension Date {
    var weekday: Int {
        return (Calendar.current.component(.weekday, from: self) - 2) % 7 < 0 ? 7 + (Calendar.current.component(.weekday, from: self) - 2) % 7 : (Calendar.current.component(.weekday, from: self) - 2) % 7
    }
    var firstDayOfTheMonth: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
    }
}

extension String {
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MMMM-dd"
        return formatter
    }()

    var date: Date? {
        return String.dateFormatter.date(from: self)
    }
}

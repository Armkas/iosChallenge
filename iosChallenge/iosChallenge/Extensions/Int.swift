//
//  Int.swift
//  iosChallenge
//
//  Created by puyue on R 3/08/28.
//

import Foundation

extension Int {
    internal func toDateString() -> String {
        let date = Date.init(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.init(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.string(from: date)
    }
}

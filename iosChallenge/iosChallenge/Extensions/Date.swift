//
//  Date.swift
//  iosChallenge
//
//  Created by puyue on R 3/08/28.
//

import Foundation

extension Date {
    static func getCurrentDateTime() -> String {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return df.string(from: date)
    }
}



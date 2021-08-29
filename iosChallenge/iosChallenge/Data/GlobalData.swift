//
//  GlobalData.swift
//  iosChallenge
//
//  Created by puyue on R 3/08/29.
//

import Foundation

internal struct GlobalData {
    static var timestamp: Int?
    static var source: String?
    static var quotes: [String : Double]? {
        didSet {
            guard let quotes = quotes else { return }
            countries = [String](quotes.keys).map { $0.subString(from: 3) } // "USDJPY" → "JPY"
            rates = [Double](quotes.values)
            guard let countries = countries, let rates = rates else { return }
            country_rate = zip(countries, rates).map { $0 }
        }
    }
    static var countries: [String]?
    static var rates: [Double]?
    static var country_rate: [(String, Double)]?
    static var isSyncing = false {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("SyncStateChange"), object: nil)
        }
    }
}



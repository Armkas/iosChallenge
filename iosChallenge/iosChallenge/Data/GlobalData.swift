//
//  GlobalData.swift
//  iosChallenge
//
//  Created by puyue on R 3/08/29.
//

import Foundation

internal struct GlobalData {
    static var timestamp: Int? // In Free plan, the timestamp in the server is only updated once a day, it is GMT time 11:53
    static var lastAccessTime: Int?
    static var source: String?
    static var quotes: [String : Double]? {
        didSet {
            guard let quotes = quotes else { return }
            currencies = [String](quotes.keys).map { $0.subString(from: 3) } // "USDJPY" → "JPY"
            rates = [Double](quotes.values)
            guard let currencies = currencies, let rates = rates else { return }
            currency_rate = zip(currencies, rates).map { $0 }
        }
    }
    static var currencies: [String]?
    static var rates: [Double]?
    static var currency_rate: [(String, Double)]?
    static var isSyncing = false {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("SyncStateChange"), object: nil)
        }
    }
}



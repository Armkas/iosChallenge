//
//  GlobalData.swift
//  iosChallenge
//
//  Created by puyue on R 3/08/29.
//

//internal struct Currencies {
//    static var currencies: [String : String]?
//    static var isSyncing = false
//}

internal struct Rates {
    static var timestamp: Int?
    static var source: String?
    static var quotes: [String : Double]? {
        didSet {
            guard let quotes = quotes else { return }
            currencies = [String](quotes.keys).map { $0.subString(from: 3) } // "USDJPY" → "JPY"
            rates = [Double](quotes.values)
        }
    }
    static var currencies: [String]?
    static var rates: [Double]?
    static var isSyncing = false
}



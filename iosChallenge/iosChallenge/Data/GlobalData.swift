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
            let countries = [String](quotes.keys).map { $0.subString(from: 3) } // "USDJPY" → "JPY"
            let rates = [Double](quotes.values)
            country_rate = zip(countries, rates).map { $0 }
        }
    }
    static var country_rate: [(String, Double)]?
    static var isSyncing = false
}



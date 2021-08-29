//
//  GlobalData.swift
//  iosChallenge
//
//  Created by puyue on R 3/08/29.
//

internal struct Currencies {
    static var currencies: [String : String]?
    static var isSyncing = false
}

internal struct Rates {
    static var timestamp: Int?
    static var source: String?
    static var quotes: [String : Double]?
    static var isSyncing = false
}



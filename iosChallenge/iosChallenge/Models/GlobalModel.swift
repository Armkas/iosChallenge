//
//  GlobalModel.swift
//  iosChallenge
//
//  Created by puyue on R 3/08/28.
//

import Foundation

//internal struct Rate {
//    var source: String
//    var target: String
//    var value: Double
//}

//internal struct Currency {
//    var source: String
//    var timestamp: Int
//    var privacy: String
//    var terms: String
//    var success: Bool
//    var lastUpdate: Date
//    var quotes: [Rate]
//}

internal struct CountriesResult: Decodable {
    let success: Bool
    let currencies: [String: String]
}

internal struct RatesResult: Decodable {
    let success: Bool
    let timestamp: Int
    let source: String
    let quotes: [String: Double]
}

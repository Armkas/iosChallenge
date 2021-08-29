//
//  GlobalModel.swift
//  iosChallenge
//
//  Created by puyue on R 3/08/28.
//

internal struct RatesResult: Decodable {
    let success: Bool
    let timestamp: Int
    let source: String
    let quotes: [String: Double]
}

//
//  GlobalUrl.swift
//  iosChallenge
//
//  Created by puyue on R 3/08/29.
//

internal struct GlobalUrl {
    static let baseUrl = "http://api.currencylayer.com" // Do not use "https" , it will fail
    static let access_key = "f6fbf49394a6f17e75e64ef2662a89b6"
    static let get_all_rate_base_USD = "\(baseUrl)/live?access_key=\(access_key)&source=USD"
}

/*
 By documentation : https://currencylayer.com/documentation
 Free plan can only use the following 4 API:
 # Supported Currencies:
 # Real-time Rates:
 # Historical Rates
 # Specify Output Currencies
 
 Bacause of following 3 reason, I only get all [Real-time Rates] base on USD
 1. In the free plan, getting too much data at the same time will cause the API to fail.
 2. [Real-time Rates] also can get a list of all currencies by calculations.
 3. Functional Requirements require apps not to use API too frequently, so [Specify Output Currencies] cannot be used
 */

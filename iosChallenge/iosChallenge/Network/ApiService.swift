//
//  ApiService.swift
//  iosChallenge
//
//  Created by puyue on R 3/08/29.
//

import Foundation

struct ApiService {
    
    static let shared = ApiService()
    
    func fetchApiData(urlString: String, completion: @escaping (String?, Error?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            if let err = err {
                print("Failed to get data:", err)
                completion(nil, err)
                return
            }
            if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Succeed to get data:", jsonString)
                    completion(jsonString, nil)
                }
            }
        }.resume()
    }
}


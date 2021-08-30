//
//  ApiService.swift
//  iosChallenge
//
//  Created by puyue on R 3/08/29.
//

import Foundation

struct ApiService {
    
    static let shared = ApiService()
    
    func getRatesAndSave() {
        let url = GlobalUrl.get_all_rate_base_USD
        GlobalData.isSyncing = true
        fetchApiData(urlString: url) { (data, err)  in
            if let _ = err {
                self.apiError()
                return
            }
            if let data = data,
               let ratesResult = try? JSONDecoder().decode(RatesResult.self, from: Data(data.utf8)), ratesResult.success {
                guard ratesResult.success else {
                    self.apiError()
                    return
                }
                GlobalData.timestamp = ratesResult.timestamp
                GlobalData.lastAccessTime = Int(Date().timeIntervalSince1970)
                GlobalData.source = ratesResult.source
                GlobalData.quotes = ratesResult.quotes
                GlobalData.isSyncing = false
            }
        }
    }
    
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
    
    func apiError() {
        NotificationCenter.default.post(name: Notification.Name("APIError"), object: nil)
        GlobalData.isSyncing = false
    }

}


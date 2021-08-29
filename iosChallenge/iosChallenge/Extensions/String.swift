//
//  String.swift
//  iosChallenge
//
//  Created by puyue on R 3/08/29.
//

import Foundation

extension String {
   
    func subString(from: Int) -> String {
        let index: String.Index = self.index(startIndex, offsetBy: from)
        return String(self[index ..< endIndex])
    }
    
}

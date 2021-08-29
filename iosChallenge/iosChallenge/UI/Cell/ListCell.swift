//
//  listCell.swift
//  iosChallenge
//
//  Created by puyue on R 3/08/28.
//

import Foundation
import UIKit

class ListCell: UITableViewCell {

    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    func bind(_ countryRate: (String, Double)) {
        currencyLabel.text = countryRate.0
        rateLabel.text = "\(countryRate.1)"
    }
    
}

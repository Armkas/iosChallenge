//
//  listCell.swift
//  iosChallenge
//
//  Created by puyue on R 3/08/28.
//

import Foundation
import UIKit

class ListCell: UITableViewCell {

    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func bind(_ countryRate: (String, Double)) {
        countryLabel.text = countryRate.0
        rateLabel.text = "\(countryRate.1)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

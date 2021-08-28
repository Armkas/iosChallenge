//
//  listCell.swift
//  iosChallenge
//
//  Created by puyue on R 3/08/28.
//

import Foundation
import UIKit

internal final class ListCell: UITableViewCell {

    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func bind(rate: Rate) {
        countryLabel.text = rate.targetCountry
        rateLabel.text = "\(rate.value)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

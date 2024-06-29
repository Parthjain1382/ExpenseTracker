//
//  TransactionTableViewCell.swift
//  Danam2.0
//
//  Created by E5000846 on 29/06/24.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    static let identifer = "TransactionTableViewCell"
    
    @IBOutlet weak var tranHeadingLb: UILabel!
    
    @IBOutlet weak var transDescLb: UILabel!
    
    @IBOutlet weak var amountSpendLb: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

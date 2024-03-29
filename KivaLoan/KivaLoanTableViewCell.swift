//
//  KivaLoanTableViewCell.swift
//  KivaLoan
//
//  Created by Mohsin Ali Ayub on 15.04.22.
//  Copyright © 2022 AppCoda. All rights reserved.
//

import UIKit

class KivaLoanTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel:UILabel! {
        didSet {
            nameLabel.numberOfLines = 0
        }
    }
    @IBOutlet weak var countryLabel:UILabel! {
        didSet {
            countryLabel.numberOfLines = 0
        }
    }
    @IBOutlet weak var useLabel:UILabel! {
        didSet {
            useLabel.numberOfLines = 0
        }
    }
    @IBOutlet weak var amountLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with loan: Loan) {
        nameLabel.text = loan.name
        countryLabel.text = loan.country
        useLabel.text = loan.use
        amountLabel.text = "$\(loan.amount)"
    }

}

//
//  LoanBookTVC.swift
//  homelib
//
//  Created by Shalu Scaria on 2018-02-15.
//  Copyright © 2018 Shalu Scaria. All rights reserved.
//

import UIKit

class LoanBookTVC: UITableViewCell {

    
    @IBOutlet var loanImage: UIImageView!
    
    @IBOutlet var loanAuthor: UILabel!
    @IBOutlet var loanTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

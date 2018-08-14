//
//  AuthorTableViewCell.swift
//  homelib
//
//  Created by Shalu Scaria on 2018-02-13.
//  Copyright © 2018 Shalu Scaria. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell {
    
    
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var detailTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

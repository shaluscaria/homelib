//
//  TitleDisplayTableViewCell.swift
//  homelib
//
//  Created by Shalu Scaria on 2018-02-13.
//  Copyright © 2018 Shalu Scaria. All rights reserved.
//

import UIKit

class TitleDisplayTableViewCell: UITableViewCell {

    @IBOutlet var detailImage: UIImageView!
    @IBOutlet var detailTitle: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

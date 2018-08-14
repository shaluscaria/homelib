//
//  SettingsTableViewCell.swift
//  homelib
//
//  Created by Shalu Scaria on 2018-02-15.
//  Copyright © 2018 Shalu Scaria. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    
    @IBOutlet var settingsImage: UIImageView!
    @IBOutlet var settingsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

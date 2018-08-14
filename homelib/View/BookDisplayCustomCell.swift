//
//  BookDisplayCustomCell.swift
//  homelib
//
//  Created by Shalu Scaria on 2018-02-09.
//  Copyright © 2018 Shalu Scaria. All rights reserved.
//

import UIKit

class BookDisplayCustomCell: UITableViewCell {
   
    @IBOutlet var bookDetails_image: UIImageView!
    
    @IBOutlet var bookDetails_author: UILabel!
    @IBOutlet var bookDetails_title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    

}

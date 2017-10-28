//
//  TableViewCell.swift
//  FatBit
//
//  Created by Anirudh Natarajan on 10/28/17.
//  Copyright © 2017 Anirudh Natarajan. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet var thumbnail: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var location: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

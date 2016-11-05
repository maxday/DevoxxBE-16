//
//  ColorSchemeTableViewCell.swift
//  hash2colors
//
//  Created by Maxime on 05.11.16.
//  Copyright © 2016 Maxime. All rights reserved.
//

import UIKit

class ColorSchemeTableViewCell: UITableViewCell {

    @IBOutlet var color0: UIView!
    @IBOutlet var color1: UIView!
    @IBOutlet var color2: UIView!
    @IBOutlet var color3: UIView!
    @IBOutlet var color4: UIView!
    @IBOutlet var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}

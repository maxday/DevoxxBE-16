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
    
    func feed(colorArray : [UIColor], widthArray : [Int], label : String) {
        color0?.backgroundColor = colorArray[0]
        color1?.backgroundColor = colorArray[1]
        color2?.backgroundColor = colorArray[2]
        color3?.backgroundColor = colorArray[3]
        color4?.backgroundColor = colorArray[4]

        color0?.constraints[0].constant = CGFloat(widthArray[0])
        color1?.constraints[0].constant = CGFloat(widthArray[1])
        color2?.constraints[0].constant = CGFloat(widthArray[2])
        color3?.constraints[0].constant = CGFloat(widthArray[3])
        color4?.constraints[0].constant = CGFloat(widthArray[4])
        
        self.label?.text = label
    }
}

//
//  HashTextTable.swift
//  hash2colors
//
//  Created by Maxime on 15/10/16.
//  Copyright © 2016 Maxime. All rights reserved.
//

import Foundation
import UIKit

class HashTextTable: UITableViewController, UITextViewDelegate {

    @IBOutlet var hashTextView: UITextView!
    
    @IBOutlet var color0: UIView!
    @IBOutlet var color1: UIView!
    @IBOutlet var color2: UIView!
    @IBOutlet var color3: UIView!
    @IBOutlet var color4: UIView!
    
    override func viewDidLoad() {
        hashTextView.textColor = UIColor.lightGray
        hashTextView.text = "Type your thoughts here..."
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "viewColorDetail") {
            if let colorDetail = segue.destination as? ColorDetail {
                colorDetail.updateBackgroundColor()
            }
        }
    }
}

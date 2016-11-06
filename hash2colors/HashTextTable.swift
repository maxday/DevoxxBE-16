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
    
    var currentColor:HashColorItem?
    
    override func viewDidLoad() {
        hashTextView.textColor = UIColor.lightGray
        hashTextView.text = "Enter your test here..."
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.keyboardDismissMode = .onDrag
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "viewColorDetail") {
            if let colorDetail = segue.destination as? ColorDetail {
                
                let currentSelectedColorIndex = tableView.indexPathForSelectedRow?.row
                let currentColor = self.currentColor?.getColors()[currentSelectedColorIndex!].toUIColor()
                colorDetail.updateBackgroundColor(color: currentColor!)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let cellColor = cell as? ColorCellTableView {
            cellColor.colorCode.text = "#o"
            cellColor.colorPreview.backgroundColor = currentColor?.getColors()[indexPath.row].toUIColor()
            cellColor.colorFriendlyName.text = "Color \(indexPath.row) :"
        }
        return cell
    }
    
}

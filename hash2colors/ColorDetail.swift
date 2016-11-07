//
//  ColorDetail.swift
//  hash2colors
//
//  Created by Maxime on 05.11.16.
//  Copyright © 2016 Maxime. All rights reserved.
//

import Foundation

import UIKit


class ColorDetail: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Color detail"
    }
    
    func updateBackgroundColor(color : UIColor) {
        self.view.backgroundColor = color
    }
}

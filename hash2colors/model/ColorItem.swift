//
//  ColorItem.swift
//  hash2colors
//
//  Created by Maxime on 09/10/16.
//  Copyright © 2016 Maxime. All rights reserved.
//

import Foundation
import UIKit

public struct ColorItem {
    
    public let red: UInt32
    public let green: UInt32
    public let blue: UInt32
    public let size: UInt32
    
    public init(red:UInt32, green:UInt32, blue:UInt32, size:UInt32) {
        self.red = red
        self.green = green
        self.blue = blue
        self.size = size
    }
    
    public func toUIColor() -> UIColor {
        return UIColor(colorLiteralRed: Float(red) / 255,
                                  green: Float(green) / 255,
                                  blue: Float(blue) / 255,
                                  alpha: 1.0)
    }
    
}

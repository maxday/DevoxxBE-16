//
//  Color.swift
//  hash2colors
//
//  Created by Maxime on 10.11.16.
//  Copyright © 2016 Maxime. All rights reserved.
//

import Foundation
import UIKit

public struct Color {
    private let color:String

    public let red: UInt32
    public let green: UInt32
    public let blue: UInt32
    public let ratio: UInt32
    
    public init(color : String, ratio : String) {
        self.color = color
        var rgbValue:UInt32 = 0
        var ratioValue:UInt32 = 0
        Scanner(string: color).scanHexInt32(&rgbValue)
        Scanner(string: ratio).scanHexInt32(&ratioValue)
        (self.ratio, self.red, self.green, self.blue) = (ratioValue & 0xFF, rgbValue >> 16, rgbValue >> 8 & 0xFF, rgbValue & 0xFF)
    }
    
    public func getRatio() -> UInt32 {
        return ratio
    }
    
    public func toUIColor() -> UIColor {
        return UIColor(colorLiteralRed: Float(red) / 255,
                       green: Float(green) / 255,
                       blue: Float(blue) / 255,
                       alpha: 1.0)
    }
    
    public func getColorAsString() -> String {
        return color
    }
}

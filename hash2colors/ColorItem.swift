//
//  ColorItem.swift
//  hash2colors
//
//  Created by Maxime on 09/10/16.
//  Copyright © 2016 Maxime. All rights reserved.
//

import Foundation

public struct ColorItem {
    
    public let red: Int
    public let green: Int
    public let blue: Int
    public let size: Int
    
    public init(red:UInt32, green:UInt32, blue:UInt32, alpha:UInt32) {
        self.red = Int(red)
        self.green = Int(green)
        self.blue = Int(blue)
        self.size = Int(alpha)
    }
    
}

extension ColorItem : DictionaryConvertible {
    
    func toDictionary() -> JSONDictionary {
        var result = JSONDictionary()
        result["red"] = self.red
        result["green"] = self.green
        result["blue"] = self.blue
        result["size"] = self.size
        return result
    }
    
}
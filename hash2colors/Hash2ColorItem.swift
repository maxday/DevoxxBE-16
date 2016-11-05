//
//  HashColorItem.swift
//  Hash2Colors
//
//  Created by Maxime on 08/10/16.
//
//

import Foundation

public struct HashColorItem {
    
    public let hashString: String
    public var colors: [ColorItem]?
    public var totalSize: Int?
    
    public init(hashString: String, colors: [ColorItem]) {
        self.hashString = hashString
        self.colors = colors
    }
    
    public init(hash: String) {
        self.hashString = hash
        self.colors = extractColors(hash: hash, result: [])
        self.totalSize = sumColorSizes()
    }
    
    public func extractStringColors(hash: String, result: [String]) -> [String] {
        if hash.characters.count == 0 {
            return result
        }
        let startIndexColor = hash.index(hash.startIndex, offsetBy: 0)
        let endIndexColor = hash.index(hash.startIndex, offsetBy: 5)
        
        let color = hash[startIndexColor...endIndexColor];
    
        var addResult = result
        addResult.append(color)
        return extractStringColors(hash: hash.substring(from: hash.index(hash.startIndex, offsetBy: 8)), result: addResult)
    }
    
    public func extractColors(hash: String, result: [ColorItem]) -> [ColorItem] {
        if hash.characters.count == 0 {
            return result
        }
        let startIndexColor = hash.index(hash.startIndex, offsetBy: 0)
        let endIndexColor = hash.index(hash.startIndex, offsetBy: 5)
        
        let startIndexAlpha = hash.index(hash.startIndex, offsetBy: 6)
        let endIndexAlpha = hash.index(hash.startIndex, offsetBy: 7)
        
        let color = hash[startIndexColor...endIndexColor];
        let size = hash[startIndexAlpha...endIndexAlpha];

        var rgbValue:UInt32 = 0
        var sizeValue:UInt32 = 0
        let a, r, g, b: UInt32
        
        Scanner(string: color).scanHexInt32(&rgbValue)
        Scanner(string: size).scanHexInt32(&sizeValue)
        (a, r, g, b) = (sizeValue & 0xFF, rgbValue >> 16, rgbValue >> 8 & 0xFF, rgbValue & 0xFF)
        
        var addResult = result
        addResult.append(ColorItem(red: r, green: g, blue: b, alpha: a))
        return extractColors(hash: hash.substring(from: hash.index(hash.startIndex, offsetBy: 8)), result: addResult)
    }
    
    public func sumColorSizes() -> Int {
        var r = 0
        for i in self.colors! {
            r+=i.size
        }
        return r
    }
    
    public func getWidth(maxSize : Float) -> [Int] {
        var returnArray = [Int]()
        var currentSummedWidth = 0
        for i in 0...(colors?.count)!-1 {
            let currentWidth = Int((Float((colors?[i].size)!) * maxSize) / Float(self.totalSize!))
            currentSummedWidth += currentWidth
            returnArray.append(currentWidth)
        }
        returnArray.append(Int(maxSize)-currentSummedWidth)
        return returnArray
    }
}

extension HashColorItem : DictionaryConvertible {
    
    func toDictionary() -> JSONDictionary {
        var result = JSONDictionary()
        result["hashString"] = self.hashString
        result["colors"] = self.colors!.toDictionary()
        result["totalSize"] = self.totalSize!
        return result
    }
    
}

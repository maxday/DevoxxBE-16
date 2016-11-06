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
    
    enum HashError: Error {
        case IncorrectLength
        case Nil
    }
    
    public init(hashString: String, colors: [ColorItem]) {
        self.hashString = hashString
        self.colors = colors
    }
    
    public init(hash: String?) throws {
        guard let hash = hash else {
            throw HashError.Nil
        }
        if hash.characters.count != 40 {
            throw HashError.IncorrectLength
        }
        self.hashString = hash
        self.colors = extractColors()
        self.totalSize = sumColorSizes()
    }
    
    public func getColorsAsString() -> [String] {
        assert(hashString.characters.count == 40, "Incorrect length for hash")
        return stride(from: 0, to: hashString.characters.count, by: 8).map { i -> String in
            let startIndex = hashString.index(hashString.startIndex, offsetBy: i)
            let endIndex  = hashString.index(startIndex, offsetBy: 8)
            return hashString[startIndex..<endIndex]
        }
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
    
    public func extractColors() -> [ColorItem] {
        
        let colorsAsString = getColorsAsString()
        
        var colorItemArray = [ColorItem]()
        
        var rgbValue:UInt32 = 0
        var sizeValue:UInt32 = 0
        var a, r, g, b: UInt32
        
        for color in colorsAsString {
            let startIndexColor = color.index(color.startIndex, offsetBy: 0)
            let endIndexColor = color.index(color.startIndex, offsetBy: 6)
            let startIndexSize = color.index(color.startIndex, offsetBy: 6)
            let endIndexSize = color.index(color.startIndex, offsetBy: 8)
            let colorValue = color[startIndexColor..<endIndexColor];
            let size = color[startIndexSize..<endIndexSize];
            
            Scanner(string: colorValue).scanHexInt32(&rgbValue)
            Scanner(string: size).scanHexInt32(&sizeValue)
            (a, r, g, b) = (sizeValue & 0xFF, rgbValue >> 16, rgbValue >> 8 & 0xFF, rgbValue & 0xFF)
            
            colorItemArray.append(ColorItem(red: r, green: g, blue: b, alpha: a))
        }
        
        return colorItemArray
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

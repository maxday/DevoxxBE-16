//
//  HashColorItem.swift
//  Hash2Colors
//
//  Created by Maxime on 08/10/16.
//
//

//unit test hash :      aaaaaa10bbbbbb20cccccc30dddddd40eeeeee50
//unit test addHash :   86f7e437faa5a7fce15d1ddcb9eaeaea377667b8

import Foundation

public struct HashColorItem {
    
    private let hashString: String
    private var colors = [HashColor]()
    private var size = 0
    
    enum HashError: Error {
        case IncorrectLength
        case Nil
    }
    
    public init(hash: String?) throws {
        guard let hash = hash else {
            throw HashError.Nil
        }
        if hash.characters.count != 40 {
            throw HashError.IncorrectLength
        }
        self.hashString = hash
        self.colors = computeColors()
        self.size = sumColorSizes()
    }
    
    //splits the hash into 5 parts of 8 chars
    private func computeColors() -> [HashColor] {
        assert(hashString.characters.count == 40, "Incorrect length for hash")
        return stride(from: 0, to: hashString.characters.count, by: 8).map { i -> HashColor in
            let startIndexColor = hashString.index(hashString.startIndex, offsetBy: i)
            let endIndexColor  = hashString.index(startIndexColor, offsetBy: 6)
            let endIndexSize  = hashString.index(startIndexColor, offsetBy: 8)
            return HashColor(color: hashString[startIndexColor..<endIndexColor], ratio: hashString[endIndexSize..<endIndexSize])
        }
    }
    
    private func sumColorSizes() -> Int {
        var r = 1
        for i in colors {
            r+=Int(i.getRatio())
        }
        return r
    }
    
    public func getWidth(maxSize : Float) -> [Int] {
        var returnArray = [Int]()
        var currentSummedWidth = 0
        for i in 0...(colors.count)-1 {
            let currentWidth = Int((Float(colors[i].getRatio()) * maxSize) / Float(self.size))
            currentSummedWidth += currentWidth
            returnArray.append(currentWidth)
        }
        returnArray.append(Int(maxSize)-currentSummedWidth)
        return returnArray
    }
    
    public func getColors() -> [HashColor] {
        return colors
    }
    
    public func getHashString() -> String {
        return hashString
    }
}

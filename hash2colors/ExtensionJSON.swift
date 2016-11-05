//
//  ExtensionJSON.swift
//  hash2colors
//
//  Created by Maxime on 09/10/16.
//  Copyright © 2016 Maxime. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String : Any]

protocol DictionaryConvertible {
    func toDictionary() -> JSONDictionary
}

extension Array where Element : DictionaryConvertible {
    func toDictionary() -> [JSONDictionary] {
        return self.map { $0.toDictionary() }
    }
}

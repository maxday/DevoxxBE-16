//
//  CompanyItem.swift
//  hash2colors
//
//  Created by Maxime on 09/10/16.
//  Copyright © 2016 Maxime. All rights reserved.
//

import Foundation

public struct CompanyItem {
    
    public let percentAnswers: Int
    public let name: String
    public let nbTweetsToday: Int
    public let averageAnswersTimeInSec: Int
    
    public init(percentAnswers:Int, name:String, nbTweetsToday:Int, averageAnswersTimeInSec:Int) {
        self.percentAnswers = percentAnswers
        self.name = name
        self.nbTweetsToday = nbTweetsToday
        self.averageAnswersTimeInSec = averageAnswersTimeInSec
    }
    
}

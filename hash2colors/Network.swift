//
//  Network.swift
//  hash2colors
//
//  Created by Maxime on 09/10/16.
//  Copyright © 2016 Maxime. All rights reserved.
//

import Foundation
import UIKit

extension HashColorItem {
    init?(dictionary: JSONDictionary) {
        guard let hashString = dictionary["hashString"] as? String,
            let totalSize = dictionary["totalSize"] as? Int,
            let colors = dictionary["colors"] as? [JSONDictionary] else {
                print(dictionary["colors"])
                return nil
        }
        self.hashString = hashString
        self.totalSize = totalSize
        self.colors = colors.flatMap(ColorItem.init)
        
        print(colors.flatMap(ColorItem.init))
        
    }
}

extension ColorItem {
    init?(dictionary: JSONDictionary) {
        guard let red = dictionary["red"] as? Int,
            let green = dictionary["green"] as? Int,
            let blue = dictionary["blue"] as? Int,
            let totalSize = dictionary["size"] as? Int else {
                return nil
        }
        self.red = red
        self.green = green
        self.blue = blue
        self.size = totalSize
    }
}

extension CompanyItem {
    init?(dictionary: JSONDictionary) {
        guard let percentAnswers = dictionary["percentAnswers"] as? Int,
            let name = dictionary["name"] as? String,
            let averageAnswersTimeInSec = dictionary["averageAnswersTimeInSec"] as? Int,
            let nbTweetsToday = dictionary["nbTweetsToday"] as? Int else {
                return nil
        }
        self.percentAnswers = percentAnswers
        self.name = name
        self.nbTweetsToday = nbTweetsToday
        self.averageAnswersTimeInSec = averageAnswersTimeInSec
    }
}

struct Resource<A> {
    let url: NSURL
    let parse: (NSData) -> A?
}

extension Resource {
    init(url: NSURL, parseJSON: @escaping (Any) -> A?) {
        self.url = url
        self.parse = { data in
            let json = try? JSONSerialization.jsonObject(with: data as Data, options: [])
            return json.flatMap(parseJSON)
        }
    }
}

extension CompanyItem {
    static let all = Resource<[CompanyItem]>(url: NSURL(string :"http://demospark.eu-gb.mybluemix.net/api/stats")!, parseJSON: { json in
        guard let dictionaries = json as? [JSONDictionary] else { return nil }
        return dictionaries.flatMap(CompanyItem.init)
    })
}

extension HashColorItem {
    static let all = Resource<[HashColorItem]>(url: NSURL(string :"http://localhost:8090/list")!, parseJSON: { json in
        guard let dictionaries = json as? [JSONDictionary] else { return nil }
        return dictionaries.flatMap(HashColorItem.init)
    })
    static let add = Resource<HashColorItem>(url: NSURL(string :"http://localhost:8090/hash/add/cf23df2207d99a74fbe169e3eba035e633b65d94")!, parseJSON: { json in
        guard let dictionary = json as? JSONDictionary else { return nil }
        return HashColorItem(dictionary:dictionary)
    })
    
    static func add(hashString : String) -> Resource<HashColorItem> {
        let a = Resource<HashColorItem>(
            url: NSURL(string :"http://localhost:8090/hash/add/\(hashString)")!,
            parseJSON: {
                json in
                    print("http://localhost:8090/hash/add/\(hashString)")
                    guard let dictionary = json as? JSONDictionary else { return nil }
                return HashColorItem(dictionary:dictionary)
            }
        )
        return a
    }
}


final class Webservice {
    func load<A>(resource: Resource<A>, completion: @escaping (A?) -> ()) {
        URLSession.shared.dataTask(with: resource.url as URL) { data, _, _ in
            guard let data = data else {
                completion(nil)
                return
            }
            completion(resource.parse(data as NSData))
            }.resume()
    }
}

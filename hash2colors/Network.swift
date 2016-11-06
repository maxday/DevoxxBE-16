//
//  Network.swift
//  hash2colors
//
//  Created by Maxime on 09/10/16.
//  Copyright © 2016 Maxime. All rights reserved.
//

import Foundation
import UIKit

typealias JSONDictionary = [String : Any]

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

extension HashColorItem {
    static let all = Resource<[String]>(url: NSURL(string :"https://hash2colors.herokuapp.com/hash/list")!, parseJSON: { json in
        guard let dictionaries = json as? [JSONDictionary] else { return nil }
        return dictionaries.map({$0["hash"] as! String})
    })
        
    static func add(hashString : String) -> Resource<String> {
        let a = Resource<String>(
            url: NSURL(string :"https://hash2colors.herokuapp.com/hash/add/\(hashString)")!,
            parseJSON: {
                json in
                    guard let dictionary = json as? JSONDictionary else { return nil }
                return dictionary["hash"] as? String
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

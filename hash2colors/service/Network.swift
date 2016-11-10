//
//  Network.swift
//  hash2colors
//
//  Created by Maxime on 09/10/16.
//  Copyright © 2016 Maxime. All rights reserved.
//

// Inspired by a great talk @https://talk.objc.io/episodes/S01E01-networking

import Foundation
import UIKit

typealias JSONDictionary = [String : Any]

struct Resource<A> {
    var url: NSURL
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

extension ColorScheme {
    
    static func getBaseUrl() -> String {
        let uiTesting = ProcessInfo.processInfo.arguments.contains("ui-testing")
        let key = (uiTesting) ? "CFEndpointUrlTest" : "CFEndpointUrl"
        if let url = Bundle.main.object(forInfoDictionaryKey: key) as? String {
            return url
        }
        return ""
    }
    
    static let all = Resource<[String]>(url: NSURL(string :"\(getBaseUrl())/hash/list")!, parseJSON: { json in
        guard let dictionaries = json as? [JSONDictionary] else { return nil }
        return dictionaries.map({$0["hash"] as! String})
    })
    
    static func add(baseUrl : String, hashString : String) -> Resource<String> {
        let a = Resource<String>(
            url: NSURL(string :"\(baseUrl)/hash/add/\(hashString)")!,
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

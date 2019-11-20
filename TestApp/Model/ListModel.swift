//
//  ListModel.swift
//  TestApp
//
//  Created by Veera Diande on 20/11/19.
//  Copyright © 2019 Brandenburg. All rights reserved.
//

import Foundation
public func dataFromFile(_ filename: String) -> Data? {
    @objc class TestClass: NSObject { }
    
    let bundle = Bundle(for: TestClass.self)
    if let path = bundle.path(forResource: filename, ofType: "json") {
        return (try? Data(contentsOf: URL(fileURLWithPath: path)))
    }
    return nil
}

class Lists {
    var list = [List]()
    init?(data: Data) {
        do {
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any], let body = json["data"] as? [String: Any] {
                if let lists = body["rows"] as? [[String: Any]] {
                    self.list = lists.map { List(json: $0) }
                }
            }
        } catch {
            print("Error deserializing JSON: \(error)")
            return nil
        }
    }
}
class List {
    var title: String?
    var desc: String?
    var url: String?

    init(json: [String: Any]) {
        self.title = json["title"] as? String
        self.url = json["imageHref"] as? String
        self.desc = json["description"] as? String
    }
}

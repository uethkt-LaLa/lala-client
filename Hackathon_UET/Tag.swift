//
//  Tag.swift
//  Hackathon_UET
//
//  Created by Anh Tuan on 3/10/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit
import SwiftyJSON

class Tag: NSObject {
    var id : String
    var name : String
    var followers : [String]
    var posts : [String]
    init(json : JSON) {
        self.id = json["_id"].stringValue
        self.name = json["name"].stringValue
        self.followers = [String]()
        for item in json["followers"].arrayValue {
            let str = item.stringValue
            self.followers.append(str)
        }
        self.posts = [String]()
        for item in json["posts"].arrayValue {
            let str = item.stringValue
            self.posts.append(str)
        }
        
    }
    
}

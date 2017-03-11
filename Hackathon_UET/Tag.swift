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
    var followers_count : Int
    var post_count : Int
    var select : Bool = false
    var image_url : String
//    var followers : [String]
//    var posts : [String]
    init(json : JSON) {
        self.id = json["_id"].stringValue
        self.name = json["name"].stringValue
        var followers = [String]()
        for item in json["followers"].arrayValue {
            let str = item.stringValue
            followers.append(str)
        }
        self.followers_count = followers.count
        
        var posts = [String]()
        for item in json["posts"].arrayValue {
            let str = item.stringValue
            posts.append(str)
        }
        self.post_count = posts.count
        self.image_url = json["image_url"].stringValue
    }
    
}

//
//  User.swift
//  Hackathon_UET
//
//  Created by Anh Tuan on 3/10/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit
import SwiftyJSON

class User: NSObject {
    var id : String
    var username : String
    var email : String
    var gender : Bool
    var join_date : String
    var followers : [String]
    var following_categories : [String]
    var following_tags : [String]
    var following_posts : [String]
    var followings : [String]
    init(json : JSON) {
        self.id = json["_id"].stringValue
        self.username = json["username"].stringValue
        self.email = json["email"].stringValue
        self.gender = json["gender"].boolValue
        self.join_date = json["join_date"].stringValue
        self.followers = [String]()
        for item in json["followers"].arrayValue {
            let val = item.stringValue
            self.followers.append(val)
        }
        
        self.following_categories = [String]()
        for item in json["following_categories"].arrayValue {
            let val = item.stringValue
            self.following_categories.append(val)
        }
        
        self.following_tags = [String]()
        for item in json["following_tags"].arrayValue {
            let val = item.stringValue
            self.following_tags.append(val)
        }
        
        self.following_posts = [String]()
        for item in json["following_posts"].arrayValue {
            let val = item.stringValue
            self.following_posts.append(val)
        }
        
        self.followings = [String]()
        for item in json["followings"].arrayValue {
            let val = item.stringValue
            self.followings.append(val)
        }
        
    }
}

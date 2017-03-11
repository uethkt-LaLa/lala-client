//
//  PopularUser.swift
//  Hackathon_UET
//
//  Created by Anh Tuan on 3/10/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit
import SwiftyJSON

class PopularUser: NSObject {
    var id : String
    var username : String
    var avatarUser : String
    var popular : Int
    var join_date : String
    var follower_count : Int
    
    init(json : JSON) {
        self.avatarUser = json["image_url"].stringValue
        self.id = json["_id"].stringValue
        self.username = json["display_name"].stringValue
        self.popular = json["popular"].intValue
        let join_date = json["join_date"].stringValue
        let dateformat = DateFormatter()
        let date2 = dateformat.convertFromISO(string: join_date)
        dateformat.dateFormat = "dd-MM-yyyy"
        self.join_date = dateformat.string(from: date2)
        
        let fols = json["followers"].arrayValue
        self.follower_count = fols.count        
    }
    
    /*"_id": "58ba468ddfae86239b973adc",
    "username": "admin",
    "password": "$2a$05$QRuoIAjD42Lu2UnzFBZB0eqPOV7if9aINgZaSu6CwymbU9aTjkFF2",
    "email": "admin@gmail.com",
    "gender": true,
    "__v": 0,
    "popular": 6,
    "join_date": "2017-03-04T04:46:05.821Z",
    "followers": [],
    "following_categories": [
    "58ba5b018f28a73901d3279a"
    ],
    "following_tags": [
    "58ba61fdf2d63440d23f0450",
    "58c1833aaa13050004475ca7",
    "58c18350aa13050004475ca8"
    ],
    "following_posts": [],
    "followings": [
    "58ba36215d567616c66ab8d4"
    ]*/
}

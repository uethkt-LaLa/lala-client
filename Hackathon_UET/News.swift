//
//  News.swift
//  Hackathon_UET
//
//  Created by Anh Tuan on 3/10/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit
import SwiftyJSON

class News: NSObject {
    var id : String
    var userId : String
    var categoryID : String
    var descriptionData : String
    var created_time : String
    var followers : [String]
    var comments : [String]
    var dislikes_count : Int
    var likes_count : Int
    var is_published : Bool
    var tags : [String]
    var imagePath : [String]
    
    init(json : JSON) {
        self.id = json["_id"].stringValue
        self.imagePath = [String]()
        self.imagePath.append("https://www.w3schools.com/css/img_fjords.jpg")
        self.imagePath.append("https://www.w3schools.com/css/img_fjords.jpg")
        self.imagePath.append("https://www.w3schools.com/css/img_fjords.jpg")
        self.userId = json["userId"].stringValue
        self.categoryID = json["categoryId"].stringValue
        self.descriptionData = json["description"].stringValue
        let dateFormmater = DateFormatter()
        let created_time = json["created_time"].stringValue
        
        //let date = dateFormmater.string(from: dateFormmater.date(from: created_time)!)
        
        self.created_time = ""
        self.followers = [String]()
        for item in json["followers"].array! {
            let val = item.stringValue
            self.followers.append(val)
        }
        self.comments = [String]()
        for item in json["comments"].array! {
            let val = item.stringValue
            self.comments.append(val)
        }
        self.dislikes_count = json["dislikes_count"].intValue
        self.likes_count = json["likes_count"].intValue
        self.is_published = json["is_published"].boolValue
        self.tags = [String]()
        for item in json["tags"].array! {
            let val = item.stringValue
            self.tags.append(val)
        }
    }
    /*
    [
    {
    "_id": "58ba8fbc8407511b21d376ef",
    "userId": "58ba468ddfae86239b973adc",
    "categoryId": "58ba8e8068a77a1695cdb01a",
    "description": "Something about computer hacking.",
    "__v": 0,
    "created_time": "2017-03-04T09:58:20.166Z",
    "followers": [],
    "comments": [
    "58c18206aa13050004475ca6"
    ],
    "dislikes_count": 0,
    "likes_count": 0,
    "is_published": true,
    "tags": []
    }
    ]
    */
}

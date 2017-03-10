//
//  News.swift
//  Hackathon_UET
//
//  Created by Anh Tuan on 3/10/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

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
    var isLike : Bool
    var isDisLike : Bool
    
    init(json : JSON) {
        self.id = json["_id"].stringValue
        self.imagePath = [String]()
        self.imagePath.append("https://www.w3schools.com/css/img_fjords.jpg")
        self.imagePath.append("https://www.w3schools.com/css/img_fjords.jpg")
        self.imagePath.append("https://www.w3schools.com/css/img_fjords.jpg")
        self.userId = json["userId"].stringValue
        self.categoryID = json["categoryId"].stringValue
        self.descriptionData = json["description"].stringValue        
        let created_time = json["created_time"].stringValue
        self.created_time = created_time
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
        let likeArr = json["likes"].arrayValue
        
        
        self.likes_count = 0
        self.isLike = false
        let disLikeArr = json["dislikes"].arrayValue
        for item in likeArr {
            let val = item.stringValue
            if UltilsUser.userId == val {
                self.isLike = true
            }
            self.likes_count = self.likes_count + 1
        }
        
        self.dislikes_count = 0
        self.isDisLike = false
        for item in disLikeArr {
            let val = item.stringValue
            if UltilsUser.userId == val {
                self.isDisLike = true
            }
            self.dislikes_count = self.dislikes_count + 1
        }
        
        self.is_published = json["is_published"].boolValue
        self.tags = [String]()
        for item in json["tags"].array! {
            let val = item.stringValue
            self.tags.append(val)
        }
    }
}

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
    var isFollow : Bool
    var userAvatar : String
    var userName : String
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
        self.userAvatar = json["userAvatar"].stringValue
        self.userName = json["display_name"].stringValue
        self.followers = [String]()
        
        self.isFollow = false
        for item in json["followers"].array! {
            let val = item.stringValue
            if UltilsUser.userId == val {
                self.isFollow = true
                break
            }
        }
        
        self.comments = [String]()
        for item in json["comments"].array! {
            let val = item.stringValue
            self.comments.append(val)
        }
        let likeArr = json["likes"].arrayValue
        self.likes_count = 0
        self.isLike = false
        
        for item in likeArr {
            let val = item.stringValue
            self.likes_count = self.likes_count + 1
            if UltilsUser.userId == val {
                self.isLike = true
                break
            }
        }
        
        let disLikeArr = json["dislikes"].arrayValue
        self.dislikes_count = 0
        self.isDisLike = false
        for item in disLikeArr {
            self.dislikes_count = self.dislikes_count + 1
            let val = item.stringValue
            if UltilsUser.userId == val {
                self.isDisLike = true
                break
            }
        }
        
        self.isFollow = false
        let followArr = json["followers"].arrayValue
        for item in followArr {
            let val = item.string
            if UltilsUser.userId == val {
                self.isFollow = true
                break
            }
        }
        
        self.is_published = json["is_published"].boolValue
        self.tags = [String]()
        for item in json["tags"].array! {
            let val = item.stringValue
            self.tags.append(val)
        }
    }
}

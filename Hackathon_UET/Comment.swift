//
//  Comment.swift
//  Hackathon_UET
//
//  Created by Anh Tuan on 3/10/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit
import SwiftyJSON

class Comment: NSObject {
    var id : String
    var postID : String
    var userID : String
    var descriptionData : String
    var created_time : String
    var dislike_count : Int
    var likes_count : Int
    var imgPaths : [String]
    var username : String
    var likes :[String]
    var  dislikes : [String]
    
    init(json : JSON) {
        self.id = json["_id"].stringValue
        self.postID = json["postId"].stringValue
        self.userID = json["userId"].stringValue
        self.descriptionData = json["description"].stringValue
        self.created_time = json["created_time"].stringValue
        self.dislike_count = json["dislikes_count"].intValue
        self.likes_count = json["likes_count"].intValue
        self.username = json["display_name"].stringValue
        self.imgPaths = []
        likes = []
        dislikes = []
        for item  in json["img_urls"].arrayValue
        {
            imgPaths.append(item.stringValue)
            
        }
        for item  in json["likes"].arrayValue
        {
            likes.append(item.stringValue)
            
        }
        for item  in json["dislikes"].arrayValue
        {
            dislikes.append(item.stringValue)
            
        }
    }
}

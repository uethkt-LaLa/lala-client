//
//  Post.swift
//  Hackathon_UET
//
//  Created by Anh Tuan on 3/11/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit
import SwiftyJSON

class Post: NSObject {
    var descriptionStr : String
    var img_paths : [String]
    var tag_id : [String]
    
    override init() {
        descriptionStr = ""
        self.img_paths = [String]()
        self.tag_id = [String]()
    }
    init(descriptionData : String , img_paths : [String] , tag_id : [String]) {
        self.descriptionStr = descriptionData
        self.img_paths = img_paths
        self.tag_id = tag_id
    }
    
    func toJSON() -> Dictionary<String, AnyObject> {
        return [
            "description" : descriptionStr as AnyObject,
            "image_urls" : self.img_paths as AnyObject,
            "tags" : self.tag_id as AnyObject
        ]
    }
}

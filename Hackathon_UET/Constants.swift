//
//  Constants.swift
//  Hackathon_UET
//
//  Created by Tuan Vu on 3/10/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import Foundation


struct GlobalVariable {
    
    static var pickImageFullHeight = 256.0 
    static var pickImageExHeight = 40.0
    
    static var pickImageFullFrame = CGRect(x: 0, y: kscreenHeight - CGFloat(GlobalVariable.pickImageFullHeight), width:kscreenWidth, height: CGFloat(GlobalVariable.pickImageFullHeight))
    static var pickImageMinFrame = CGRect(x: 0, y: kscreenHeight - CGFloat(GlobalVariable.pickImageExHeight), width:kscreenWidth, height: CGFloat(GlobalVariable.pickImageFullHeight))
    
    
}



let kImagePlaceHoler = UIImage(named: "photoholder")
let kPostContentPlaceholder = "bạn đang nghĩ gì !?"

let screenSize = UIScreen.main.bounds
let kscreenWidth = screenSize.width
let kscreenHeight = screenSize.height


let firstNameKey = "first_name"
let lastNameKey = "last_name"
let avatarUrlKey = "avatar_url"
let userkeyKey = "user_key"
let facebookIdKey = "facebook_id"
let usernameKey = "username"



let userPhoneNoKey = "phone_no"
let createdTimeKey = "created_time"
let deleteFlagKey = "delete_flag"
let groupAvatarKey = "group_avatar"
let groupNameKey = "group_name"
let groupTypeKey = "group_type"
let joinedUsersKey = "joined_users"
let lastMessageKey = "lastest_message"
let lastestMessageTimestampKey = "lastest_message_timestamp"
let updatedTimeKey = "updated_time"
let groupKeyKey = "group_key"


//MESSAGE
let messageDateKey = "message_date"
let messeageGroupIdKey = "message_group_id"
let messageOrderKey = "message_order"
let messageTextKey  = "message_text"
let messageTypeKey = "message_type"
let messageUserAvatarUrlKey = "message_user_avatar_url"
let messageUserDisplayNameKey = "message_user_display_name"
let messageUserIdKey = "message_user_id"

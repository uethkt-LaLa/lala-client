//
//  Message.swift
//  Kinly
//
//  Created by Tuan Vu on 3/6/17.
//  Copyright © 2017 tuanvu. All rights reserved.
//

import UIKit

class Message: NSObject {
    
    var deleteFlag = Int()
    var messageDate = UInt64()
    var messeageGroupId  = String()
    var messageOrder = Int()
    var messageText = String()
    var messageType = Int()
    var messageUserAvatarUrl = String()
    var messageUserDisplayName = String()
    var messageUserId = String()
    
    class func messWithDict(dict : [String : AnyObject]) -> Message
    {
        let mess = Message()
        if let deleteFag = dict[deleteFlagKey]{mess.deleteFlag = deleteFag as! Int}
        if let messageDate = dict[messageDateKey]{mess.messageDate = messageDate as! UInt64}
        if let messageGroupId = dict[messeageGroupIdKey]{mess.messeageGroupId = messageGroupId as! String}
        if let messageOrder = dict[messageOrderKey]{mess.messageOrder = messageOrder as! Int}
        if let messageText = dict[messageTextKey]{mess.messageText = messageText as! String}
        if let messageType = dict[messageTypeKey]{mess.messageType = messageType as! Int}
        if let messageUserAvatarUrl = dict[messageUserAvatarUrlKey]{mess.messageUserAvatarUrl = messageUserAvatarUrl as! String}
        if let messageUserDisplayName = dict[messageUserDisplayNameKey]{mess.messageUserDisplayName = messageUserDisplayName as! String}
        if let messageUserId = dict[messageUserIdKey]{mess.messageUserId = messageUserId as! String}
        
        return mess
    }
    
    func convertToDict() ->[String : AnyObject]
    {
        var dict : [String : AnyObject] = [:]
        
        dict[deleteFlagKey] = self.deleteFlag as AnyObject?
        dict[messageDateKey] =  self.messageDate as AnyObject?
        if self.messeageGroupId != "" { dict[messeageGroupIdKey] = self.messeageGroupId as AnyObject?}
        dict[messageOrderKey] = self.messageOrder as AnyObject?
        dict[messageTextKey] = self.messageText as AnyObject?
        dict[messageTypeKey] = self.messageType as AnyObject?
        dict[messageUserAvatarUrlKey] = self.messageUserAvatarUrl as AnyObject?
        dict[messageUserDisplayNameKey] = self.messageUserDisplayName  as AnyObject?
        dict[messageUserIdKey] = self.messageUserId as AnyObject?
        
        return dict
    }

}

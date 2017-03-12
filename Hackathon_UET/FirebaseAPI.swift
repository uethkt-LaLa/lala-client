//
//  FirebaseAPI.swift
//  Hackathon_UET
//
//  Created by Tuan Vu on 3/12/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FirebaseAPI: NSObject {
    
    class func sendMessageToFirebase(grId : String , mess : Message)
    {
        
        let ref = FIRDatabase.database().reference()
        let key = ref.child("chat").childByAutoId().key
        let chat = FIRDatabase.database().reference(withPath:"chat")
        chat.child(grId+"/"+key).setValue(mess.convertToDict()) { (error, ref) in
            
            if let err = error
            {
              
            }
        }
    }
    
    class func loadGroupsMessage(grId : String,completion:@escaping([Message]) ->())
    {
        let chat = FIRDatabase.database().reference(withPath:"chat")
        var groupMess : [Message] = []
        
        chat.child(grId).queryOrdered(byChild: "message_date").observe(.childAdded, with: { (snapshot) in
            groupMess.removeAll()
            if !(snapshot.value is NSNull)
            {
                let listDicts = snapshot.value as! [String : AnyObject]
                print("-----> \(listDicts)")
                let mess = Message.messWithDict(dict:listDicts )
                groupMess.append(mess)
                
                completion(groupMess)
            }
            
            
        })
    }

}

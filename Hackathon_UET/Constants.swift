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

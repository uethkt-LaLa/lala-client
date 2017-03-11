//
//  UltilsUser.swift
//  Hackathon_UET
//
//  Created by Anh Tuan on 3/10/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit
import FontAwesomeKit

class UltilsUser: NSObject {
    
    static func keyboardImg() -> UIImage
    {
        let icon = FAKFontAwesome.keyboardOIcon(withSize: 30)
        let iconImage = icon?.image(with: CGSize(width: 30.0, height: 30.0))
        return iconImage!
    }
    
    class func tagImage() -> UIImage
    {
        let icon = FAKFontAwesome.tagIcon(withSize: 30)
        let iconImage = icon?.image(with: CGSize(width: 30.0, height: 30.0))
        return iconImage!
    }
    
    func pictureImage() -> UIImage
    {
        let icon = FAKFontAwesome.pictureOIcon(withSize: 30)
        let iconImage = icon?.image(with: CGSize(width: 30.0, height: 30.0))
        return iconImage!
    }
    static var userId = ""
    static var kUserName = ""
    static var kPassword = ""
}

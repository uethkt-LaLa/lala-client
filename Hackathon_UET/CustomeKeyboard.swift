//
//  CustomeKeyboard.swift
//  Hackathon_UET
//
//  Created by Anh Tuan on 3/6/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit

protocol customeDelegate {
    func chooseImage()
}

class CustomeKeyboard: UIView {
    @IBOutlet weak var btnImage : UIButton!
    var delegate : customeDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func btnImageTouchUp(_ sender : UIButton){
        if delegate != nil {
            delegate?.chooseImage()
        }
    }
}

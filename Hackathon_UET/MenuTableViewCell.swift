//
//  MenuTableViewCell.swift
//  Hackathon_UET
//
//  Created by Anh Tuan on 3/5/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    @IBOutlet weak var imgView : UIImageView!
    @IBOutlet weak var lblTitle : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(obj : MenuObj) {
        //self.imgView.image = UIImage(named: obj.imgPath)
        self.lblTitle.text = obj.titleName
    }
    
}

//
//  PopularTableViewCell.swift
//  Hackathon_UET
//
//  Created by Anh Tuan on 3/11/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit

class PopularTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var btnChoose : UIButton!
    @IBOutlet weak var imgThumNail : UIImageView!
    @IBOutlet weak var lblCountPost : UILabel!
    @IBOutlet weak var lblCountFollower : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        imgThumNail.clipsToBounds = true
        imgThumNail.cornerRadius = imgThumNail.frame.width / 2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(user: PopularUser){
        lblTitle.text = user.username
        lblCountPost.text = "\(user.follower_count) followers"
        lblCountFollower.text = "\(user.popular) likes"
        imgThumNail.sd_setImage(with: URL.init(string: user.avatarUser), placeholderImage: kImagePlaceHoler)
    }
    
}

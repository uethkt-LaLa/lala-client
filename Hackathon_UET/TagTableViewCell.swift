//
//  TagTableViewCell.swift
//  Hackathon_UET
//
//  Created by Anh Tuan on 3/10/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit

class TagTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var btnChoose : UIButton!
    @IBOutlet weak var imgThumNail : UIImageView!
    @IBOutlet weak var lblCountPost : UILabel!
    @IBOutlet weak var lblCountFollower : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(item : Tag) {
        lblTitle.text = item.name
        lblCountPost.text = "\(item.post_count) posts"
        lblCountFollower.text = "\(item.followers_count) followers"
    }
    func setData(user: PopularUser){
        lblTitle.text = user.username
        lblCountPost.text = "\(user.follower_count) followers"
        lblCountFollower.text = "\(user.popular) likes"
    }
}

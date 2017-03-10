//
//  TagTableViewCell.swift
//  Hackathon_UET
//
//  Created by Anh Tuan on 3/10/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit
protocol DelegateTag {
    func chooseTouch(cell : TagTableViewCell)
}

class TagTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var btnChoose : UIButton!
    @IBOutlet weak var imgThumNail : UIImageView!
    @IBOutlet weak var lblCountPost : UILabel!
    @IBOutlet weak var lblCountFollower : UILabel!
    var delegate : DelegateTag?
    var item : Tag?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(item : Tag) {
        //imgThumNail.sd_setImage(with: URL.init(string: item.image_url))
        imgThumNail.sd_setImage(with: URL.init(string: item.image_url), placeholderImage: kImagePlaceHoler)
        self.item = item
        lblTitle.text = item.name
        lblCountPost.text = "\(item.post_count) posts"
        lblCountFollower.text = "\(item.followers_count) followers"
        if item.select == true {
            btnChoose.setImage(UIImage.init(named: "CheckMark"), for: UIControlState.normal)
        } else {
            btnChoose.setImage(UIImage.init(named: "Plus"), for: UIControlState.normal)
        }
    }
    @IBAction func chooseTouchUp(_sender : UIButton){
        if delegate != nil {
            delegate?.chooseTouch(cell: self)
        }
    }
}

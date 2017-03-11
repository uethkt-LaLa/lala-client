//
//  NewTableViewCell.swift
//  Hackathon_UET
//
//  Created by Anh Tuan on 3/10/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
protocol DelegateNewCell {
    func likeTouchUp(cell : NewTableViewCell , status : Bool)
    func dislikeTouchUp(cell : NewTableViewCell , status : Bool)
    func favTouchUp(cell : NewTableViewCell , status : Bool)
    func commentTouchUp(cell : NewTableViewCell)
    func selectImage(cell : NewTableViewCell, index : Int)
}

class NewTableViewCell: UITableViewCell {
    @IBOutlet weak var lblCountComment : UILabel!
    @IBOutlet weak var lblCountLike : UILabel!
    @IBOutlet weak var lblCountDisLike : UILabel!
    @IBOutlet weak var lblTime : UILabel!
    @IBOutlet weak var btnDisLike : UIButton!
    @IBOutlet weak var btnLike : UIButton!
    @IBOutlet weak var btnComment : UIButton!
    @IBOutlet weak var btnFav : UIButton!
    @IBOutlet weak var lblStatus : UILabel!
    @IBOutlet weak var collection : UICollectionView!
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var heightCollection: NSLayoutConstraint!
    @IBOutlet weak var imgThumbNail : UIImageView!
    @IBOutlet weak var lblTag : UILabel!
    var delegate : DelegateNewCell?
    var object: News?
    
    var layout = KRLCollectionViewGridLayout()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        layout.numberOfItemsPerLine = 1
        layout.aspectRatio = 1.0
        layout.lineSpacing = 2.0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        
        self.collection.delegate = self
        self.collection.dataSource = self        
        self.collection.register(UINib.init(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        self.collection.collectionViewLayout = layout
        self.collection.backgroundColor = .white
        imgThumbNail.clipsToBounds = true
        imgThumbNail.cornerRadius = imgThumbNail.frame.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(new : News) {
        if object?.imagePath.count == 0 {
            heightCollection.constant = 0
        } else {
            heightCollection.constant = 100
        }
        if new.descriptionData.characters.count > 500 {
            let text = new.descriptionData.substring(to: 499) + "..."
            self.lblStatus.text = new.descriptionData
        } else {
            self.lblStatus.text = new.descriptionData
        }
        let count_comment = new.comments.count
        let dis_like_count = new.dislikes_count
        let like_count = new.likes_count
        self.lblName.text = new.userName
        
//        Alamofire.request(URL_DEFINE.user_info_id+"\(new.userId)", method: .get, parameters: nil).authenticate(user: kUserName, password: kPassword).responseJSON{(response) in
//            let data = JSON.init(data: response.data!)
//            let user = User(json: data)
//            self.lblName.text = user.username
//        }
        self.imgThumbNail.sd_setImage(with: URL.init(string: new.userAvatar), placeholderImage: kImagePlaceHoler)
        self.lblCountLike.text = "\(like_count) likes"
        self.lblCountDisLike.text = "\(dis_like_count) dislikes"
        self.lblCountComment.text = "\(count_comment) comments"
        let dateFormmat = DateFormatter()
        let date2 = dateFormmat.convertFromISO(string: new.created_time)
        let minutes = Date().minutes(from: date2)
        var timeText = ""
        if minutes < 60 {
            timeText = "\(minutes) minutes ago"
        } else {
            let hours = Date().hours(from: date2) + 1
            if hours < 24 {
                timeText = "\(hours) hours ago"
            } else {
                dateFormmat.dateFormat = "dd-MM-yyyy"
                timeText = dateFormmat.string(from: date2)
            }
        }
        self.lblTime.text = timeText
        if new.isLike == true {
            btnLike.setImage(UIImage.init(named: "Vote"), for: UIControlState.normal)
        } else {
            btnLike.setImage(UIImage.init(named: "VoteNormal"), for: UIControlState.normal)
        }
        
        if new.isDisLike == true {
            btnDisLike.setImage(UIImage.init(named: "Unvote"), for: UIControlState.normal)
        } else {
            btnDisLike.setImage(UIImage.init(named: "UnvoteNormal"), for: UIControlState.normal)
        }
        
        if new.isFollow == true {
            btnFav.setImage(UIImage.init(named: "Favorite"), for: UIControlState.normal)
        } else {
            btnFav.setImage(UIImage.init(named: "UnFavorite"), for: UIControlState.normal)
        }
        //new.created_time
    }
    
    func setUser(user : User){
        self.lblName.text = user.username
    }
    
    @IBAction func btnLikeTouchUp(_ sender : UIButton) {
        if delegate != nil {
            let is_like = !(object?.isLike)!
            delegate?.likeTouchUp(cell: self, status: is_like)
        }
    }
    @IBAction func btnCommentTouchUp(_ sender : UIButton) {
        if delegate != nil {
            delegate?.commentTouchUp(cell: self)
        }
    }
    @IBAction func btnFavTouchUp(_ sender : UIButton) {
        if delegate != nil {
            let val = !(object?.isFollow)!
            delegate?.favTouchUp(cell: self, status: val)
        }
    }
    
    @IBAction func btnDisLike(_sender : UIButton){
        if delegate != nil {
            let is_disLike = !(object?.isDisLike)!
            delegate?.dislikeTouchUp(cell: self, status: is_disLike)
        }
    }
}
extension NewTableViewCell : UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return object!.imagePath.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.imgview.contentMode = .scaleAspectFill
        cell.imgview.sd_setImage(with: URL.init(string: self.object!.imagePath[indexPath.row]), placeholderImage: kImagePlaceHoler)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: collection.frame.height,height: collection.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if delegate != nil {
            delegate?.selectImage(cell: self, index: indexPath.row)
        }
    }
}

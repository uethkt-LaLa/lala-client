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
    @IBOutlet weak var btnDisLike : UIButton!
    @IBOutlet weak var btnLike : UIButton!
    @IBOutlet weak var btnComment : UIButton!
    @IBOutlet weak var btnFav : UIButton!
    @IBOutlet weak var lblStatus : UILabel!
    @IBOutlet weak var collection : UICollectionView!
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var heightCollection: NSLayoutConstraint!
    var delegate : DelegateNewCell?
    var object: News?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collection.delegate = self
        self.collection.dataSource = self        
        self.collection.register(UINib.init(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(new : News) {
        self.lblStatus.text = new.descriptionData
        let count_comment = new.comments.count
        let dis_like_count = new.dislikes_count
        let like_count = new.likes_count
        Alamofire.request(URL_DEFINE.user_info_id+"\(new.userId)", method: .get, parameters: nil).authenticate(user: "admin", password: "123456").responseJSON{(response) in
            let data = JSON.init(data: response.data!)
            let user = User(json: data)
            self.lblName.text = user.username
        }
        self.btnLike.setTitle("\(like_count)", for: UIControlState.normal)
        
    }
    
    func setUser(user : User){
        self.lblName.text = user.username
    }
    
    @IBAction func btnLikeTouchUp(_ sender : UIButton) {
        if delegate != nil {
            delegate?.likeTouchUp(cell: self, status: true)
        }
    }
    @IBAction func btnCommentTouchUp(_ sender : UIButton) {
        if delegate != nil {
            delegate?.commentTouchUp(cell: self)
        }
    }
    @IBAction func btnFavTouchUp(_ sender : UIButton) {
        if delegate != nil {
            delegate?.favTouchUp(cell: self, status: true)
        }
    }
    
    @IBAction func btnDisLike(_sender : UIButton){
        if delegate != nil {
            delegate?.dislikeTouchUp(cell: self, status: true)
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
        NSLog("\(self.object?.imagePath[indexPath.row])")
        Alamofire.request("\(self.object!.imagePath[indexPath.row])").responseData { (response) in
            let img = UIImage(data: response.data!)
            cell.imgview.image = img
        }
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

//
//  CommentCell.swift
//  Hackathon_UET
//
//  Created by Tuan Vu on 3/10/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit
import SDWebImage

protocol DelegateCommentCell {
    func touchImage(cell : CommentCell, index : Int)
}

class CommentCell: UITableViewCell, UICollectionViewDataSource , UICollectionViewDelegate {
    
    @IBOutlet weak var btnUpVote: UIButton!
    @IBOutlet weak var btnDownVote: UIButton!
    @IBOutlet weak var lblCountLike : UILabel!
    @IBOutlet weak var lblCountDisLike : UILabel!
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    @IBOutlet weak var userAvatar: UIImageView!
    
    @IBOutlet weak var lblUsername: UILabel!
    
    @IBOutlet weak var lblCommentContent: UILabel!

    @IBOutlet weak var photoCollection: UICollectionView!
    
    var cellComment : Comment? = nil
    
    var layout  = KRLCollectionViewGridLayout()
    
    let photoCellId =  "photoCellId"
    var delegate : DelegateCommentCell?
    
    
    let imgUpVoteNormal = #imageLiteral(resourceName: "VoteNormal")
    let imgUnvoteNormal = #imageLiteral(resourceName: "UnvoteNormal")
    let imgVote = #imageLiteral(resourceName: "Vote")
    let imgUnvote = #imageLiteral(resourceName: "Unvote")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configButton()
        if userAvatar != nil
        {
            self.userAvatar.layer.cornerRadius = self.userAvatar.frame.height/2
            self.userAvatar.clipsToBounds = true
            
        }
        configCollection()
        lblCommentContent.numberOfLines = 100
        
        
        // Initialization code
    }
    
    func configButton()
    {
        let spacing = 6.0 // the amount of spacing to appear between image and title
        btnUpVote.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, CGFloat(spacing));
        btnUpVote.titleEdgeInsets = UIEdgeInsetsMake(0, CGFloat(spacing), 0, 0);
    
        btnDownVote.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, CGFloat(spacing));
        btnDownVote.titleEdgeInsets = UIEdgeInsetsMake(0, CGFloat(spacing), 0, 0);
        btnUpVote.imageView?.contentMode = .scaleAspectFit
        btnDownVote.imageView?.contentMode = .scaleAspectFit
        
       btnUpVote.setImage(imgUpVoteNormal, for: .normal)
       btnDownVote.setImage(imgUnvoteNormal, for: .normal)
    }
    
    private func configCollection()
    {

        
        photoCollection.delegate = self
        photoCollection.dataSource = self
        
        layout.numberOfItemsPerLine = 1
        layout.aspectRatio = 1
        layout.lineSpacing = 2.0
        layout.sectionInset = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
        layout.scrollDirection = .horizontal
        photoCollection.collectionViewLayout = layout
        photoCollection.register(UINib(nibName: "PhotoCollectionCell", bundle: nil), forCellWithReuseIdentifier: photoCellId)
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       return  (self.cellComment!.imgPaths.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellId, for: indexPath) as! PhotoCollectionCell
        let photoUrlString  = self.cellComment?.imgPaths[indexPath.item]
        cell.photo.sd_setImage(with:URL(string: photoUrlString!) , placeholderImage: kImagePlaceHoler)
        
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if delegate != nil {
            delegate?.touchImage(cell: self, index: indexPath.row)
        }
    }
    
    
    
    
    func displayWithComment(_ comment :  Comment)
    {
//        self.userAvatar.
        self.cellComment = comment
        if comment.imgPaths.count > 0
        {
            collectionHeight.constant = 80;
            photoCollection.updateConstraints()
        }
        self.photoCollection.reloadData()
        self.lblUsername.text = comment.username
        self.lblCommentContent.text = comment.descriptionData
    
        
//        self.btnUpVote.setTitle("\(comment.likes.count)", for: .normal)
//        self.btnDownVote.setTitle("\(comment.dislikes.count)", for: .normal)
        self.lblCountLike.text = "\(comment.likes.count)"
        self.lblCountDisLike.text = "\(comment.dislikes.count)"
        if comment.isLike == true {
            self.btnUpVote.setImage(UIImage.init(named: "Vote"), for: .normal)
        } else {
            self.btnUpVote.setImage(UIImage.init(named: "VoteNormal"), for: .normal)
        }
        
        if comment.isDislike == true {
            self.btnDownVote.setImage(UIImage.init(named: "Unvote"), for: UIControlState.normal)
        } else {
            self.btnDownVote.setImage(UIImage.init(named: "UnvoteNormal"), for: UIControlState.normal)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

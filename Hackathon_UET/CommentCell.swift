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
    
    
    
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    @IBOutlet weak var userAvatar: UIImageView!
    
    @IBOutlet weak var lblUsername: UILabel!
    
    @IBOutlet weak var lblCommentContent: UILabel!

    @IBOutlet weak var photoCollection: UICollectionView!
    
    var cellComment : Comment? = nil
    
    var layout  = KRLCollectionViewGridLayout()
    
    let photoCellId =  "photoCellId"
    var delegate : DelegateCommentCell?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollection()
        lblCommentContent.numberOfLines = 100
        
        
        // Initialization code
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
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

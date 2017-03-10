//
//  ImageForPostView.swift
//  Hackathon_UET
//
//  Created by Tuan Vu on 3/11/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit
import Photos

protocol ImageForPostViewDelegate {
    
    func btnPickImageDidTap()

    
}

class ImageForPostView: UIView , UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var photoFolderCollection: UICollectionView!
    @IBOutlet weak var barOption: ImageForPostView!
    @IBOutlet weak var btnPickImage: UIButton!
    
    let photoFromFolderCellId  = "photoFromFolderCellId"
    var layout = KRLCollectionViewGridLayout()
    var delegate : ImageForPostViewDelegate?
    
    
    @IBAction func btnPickImageDidTap(_ sender: Any) {
        
        delegate?.btnPickImageDidTap()
    }
    
    override func awakeFromNib() {
        

        
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        
        
       
        
    }
    
    override func didMoveToWindow() {
        
        layout.numberOfItemsPerLine = 3
        layout.aspectRatio = 1.0
        layout.lineSpacing = 2.0
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        if photoFolderCollection != nil
        {
            photoFolderCollection.collectionViewLayout = layout
            photoFolderCollection.delegate = self
            photoFolderCollection.dataSource = self
            self.photoFolderCollection.register(UINib(nibName: "ImageFromFolderCell", bundle: nil), forCellWithReuseIdentifier: photoFromFolderCellId)
        }
        
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 6;

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:photoFromFolderCellId , for: indexPath) as! ImageFromFolderCell
        cell.photo.image =  #imageLiteral(resourceName: "ImageFolder")
        return cell
        
        
    }
    
    
    //MARK: load Image from Libs
    


}

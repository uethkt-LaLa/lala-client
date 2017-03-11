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
    func imgFolderDidTap()

    
}

class ImageForPostView: UIView , UICollectionViewDelegate, UICollectionViewDataSource , ImageFromFolderCellDelegate{
    
    @IBOutlet weak var barOptionView: UIView!
    
    @IBOutlet weak var keyboarButton: UIButton!
    @IBOutlet weak var tagButton: UIButton!
    
    
    
    @IBOutlet weak var photoSelectedHeight: NSLayoutConstraint!
    @IBOutlet weak var tagCollectionHeight: NSLayoutConstraint!
  
    
    @IBOutlet weak var photoFolderCollection: UICollectionView!

    @IBOutlet weak var btnPickImage: UIButton!
    
    let photoFromFolderCellId  = "photoFromFolderCellId"
     let photoPickedCellId  = "photoPickedCellId"
    let tagCellId = "tagCellId"
    var layoutPhotoFolder = KRLCollectionViewGridLayout()
    var layoutPhotoPicked = KRLCollectionViewGridLayout()
    var layoutTag = KRLCollectionViewGridLayout()
    var delegate : ImageForPostViewDelegate?
    
    static var frameFullInRoot : CGRect?
    static var frameMinInRoot : CGRect?
    
    @IBOutlet weak var tagCollection: UICollectionView!
    
    var listPhotoSelectect : [UIImage]  =  []
    var listTag : [String] = []
    var listImageName : [String] = []
    
    
    @IBOutlet weak var imageSelectedCollection: UICollectionView!
    
    let keyboardImage = #imageLiteral(resourceName: "chat_button_keyboard")
    let tagImage = #imageLiteral(resourceName: "post_btn_tag")
    let pictureImage = #imageLiteral(resourceName: "chat_launcher_photo")
    
    
    
    
    override func awakeFromNib() {
        
        
        for i in 1...8
        {
            let name = "Question\(i)"
            listImageName.append(name)
            
        }
        
        ImageForPostView.frameMinInRoot = CGRect(x: 0.0, y: kscreenHeight -  40, width: kscreenWidth, height: 216+40)
        ImageForPostView.frameFullInRoot = CGRect(x: 0.0, y: kscreenHeight - (216+40) , width: kscreenWidth, height: 216+40)
        
        if tagButton != nil && keyboarButton != nil {
            
            keyboarButton.setImage(keyboardImage, for: .normal)
            tagButton.setImage(tagImage, for: .normal)
            
        }
        
        
        
       
        
    }
    
    
    @IBAction func btnKeyboardDidTap(_ sender: Any) {
        
        
    }

    
    @IBAction func btnPickImageDidTap(_ sender: Any) {
        
        delegate?.btnPickImageDidTap()
    }
    
    func checkVisibleForPickedImageCollection()
    {
        
        if listPhotoSelectect.count < 1
        {
            imageSelectedCollection.isHidden = true
            photoSelectedHeight.constant = 0
            
            ImageForPostView.frameMinInRoot = CGRect(x: 0.0, y: kscreenHeight -  40, width: kscreenWidth, height: 216+40)
            ImageForPostView.frameFullInRoot = CGRect(x: 0.0, y: kscreenHeight - (216+40) , width: kscreenWidth, height: 216+40)
            
        }else
        {
            imageSelectedCollection.isHidden = false
            photoSelectedHeight.constant = 80.0
            
            ImageForPostView.frameMinInRoot = CGRect(x: 0.0, y: kscreenHeight -  (40+80), width: kscreenWidth, height: 216+40)
            ImageForPostView.frameFullInRoot = CGRect(x: 0.0, y: kscreenHeight - (216+40+80) , width: kscreenWidth, height: 216+40)

        }
        
        imageSelectedCollection.updateConstraints()
        
        
        
      
    }
    
    func checkVisibleForTagCollection()
    {
        if listTag.count < 1
        {
            tagCollection.isHidden = true
            tagCollectionHeight.constant = 0
            GlobalVariable.pickImageFullHeight -= 40.0
            GlobalVariable.pickImageExHeight -= 40.0
        }else
        {
            tagCollection.isHidden = false
            tagCollectionHeight.constant = 40.0
            tagCollection.updateConstraints()
            GlobalVariable.pickImageFullHeight += 40.0
            GlobalVariable.pickImageExHeight += 40.0
            
            
        }
        tagCollection.updateConstraints()
       
        
        
    }
    

    
    override func willMove(toSuperview newSuperview: UIView?) {
        
        
       
        
    }
    
    override func didMoveToWindow() {
        
        
        //folder
        layoutPhotoFolder.numberOfItemsPerLine = 3
        layoutPhotoFolder.aspectRatio = 1.0
        layoutPhotoFolder.lineSpacing = 2.0
        layoutPhotoFolder.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layoutPhotoFolder.scrollDirection = .vertical
        
        //picked
        layoutPhotoPicked.numberOfItemsPerLine = 1
        layoutPhotoPicked.aspectRatio = 1.0
        layoutPhotoPicked.lineSpacing = 2.0
        layoutPhotoPicked.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layoutPhotoPicked.scrollDirection = .horizontal
        
        layoutTag.numberOfItemsPerLine = 1
        layoutTag.aspectRatio = 2.5
        layoutTag.lineSpacing = 2.0
        layoutTag.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layoutTag.scrollDirection = .horizontal
        
        
        if photoFolderCollection != nil && imageSelectedCollection != nil
        {
            photoFolderCollection.collectionViewLayout = layoutPhotoFolder
            photoFolderCollection.delegate = self
            photoFolderCollection.dataSource = self
            self.photoFolderCollection.register(UINib(nibName: "ImageFromFolderCell", bundle: nil), forCellWithReuseIdentifier: photoFromFolderCellId)
            
            imageSelectedCollection.collectionViewLayout = layoutPhotoPicked
            imageSelectedCollection.delegate = self
            imageSelectedCollection.dataSource = self
            self.imageSelectedCollection.register(UINib(nibName: "ImageFromFolderCell", bundle: nil), forCellWithReuseIdentifier: photoPickedCellId)
            checkVisibleForPickedImageCollection()
            
            tagCollection.collectionViewLayout = layoutTag
            tagCollection.delegate = self
            tagCollection.dataSource = self
            self.imageSelectedCollection.register(UINib(nibName: "TagCell", bundle: nil), forCellWithReuseIdentifier: tagCellId)
            checkVisibleForTagCollection()
            
            
            
        }
        
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == imageSelectedCollection
        {
            return  listPhotoSelectect.count
        }
        
        if collectionView == tagCollection
        {
            return listTag.count
        }
        
        if collectionView == photoFolderCollection
        {
            return listImageName.count
        }
        
        return 0
        
        

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == tagCollection
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tagCellId, for: indexPath) as! TagCell
            return cell
        }
        
        if collectionView == photoFolderCollection
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:photoFromFolderCellId , for: indexPath) as! ImageFromFolderCell
            cell.setCellType(type : .photoFolder)
            let imgname = listImageName[indexPath.item]
            cell.photo.image = UIImage(named:imgname)
            cell.delegate = self
            
            return cell
        }
        
//        if collectionView == imageSelectedCollection
//        {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:photoPickedCellId , for: indexPath) as! ImageFromFolderCell
        cell.setCellType(type : .photoPicked)
        cell.photo.image =  listPhotoSelectect[indexPath.item]
        cell.delegate = self
        
            return cell
//        }
        
       

        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
  
    }
    
    func btnActionDidTap(inCell: ImageFromFolderCell) {
        
        let img =  inCell.photo.image
        
        if inCell.cellType == .photoFolder
        {

            if listPhotoSelectect.contains(img!)
            {
                listPhotoSelectect.remove(at: listPhotoSelectect.index(of: img!)!)
            }else
            {
                listPhotoSelectect.append(img!)
            }
            
            
        }
        if inCell.cellType == .photoPicked
        {
            listPhotoSelectect.remove(at: listPhotoSelectect.index(of: img!)!)
            
            for i in 0 ..< listImageName.count
            {
                let indexPath = IndexPath(item: i, section: 0)
                
            }
            
        }
        
        imageSelectedCollection.reloadData()
        checkVisibleForPickedImageCollection()
        delegate?.imgFolderDidTap()
    }
    
    
    



}

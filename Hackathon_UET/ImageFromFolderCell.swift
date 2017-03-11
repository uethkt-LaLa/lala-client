//
//  ImageFromFolderCell.swift
//  Hackathon_UET
//
//  Created by Tuan Vu on 3/11/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit

protocol ImageFromFolderCellDelegate {
    
    func btnActionDidTap(inCell : ImageFromFolderCell)
}

enum ImageFromFolderCellType {
    case photoFolder
    case photoPicked
}

class ImageFromFolderCell: UICollectionViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var btnAction: UIButton!
    
    var cellType : ImageFromFolderCellType?
    var delegate : ImageFromFolderCellDelegate?
    
    let selectedImage = #imageLiteral(resourceName: "photo_icon_selected")
    let unselectedImage = #imageLiteral(resourceName: "photo_icon_unselected")
    let removeImage = #imageLiteral(resourceName: "post_btn_removeattachment")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        

        // Initialization code
    }
    
    func setCellType(type : ImageFromFolderCellType)
    {
        self.cellType = type
        
        if btnAction != nil
        {
            if self.cellType == .photoFolder
            {
                
                btnAction.isHidden = false
                btnAction.isUserInteractionEnabled = true
                btnAction.tintColor = .green
                btnAction.setImage(unselectedImage, for: .normal)
                //TODO: set photo x
            }
            if self.cellType == .photoPicked
            {
                btnAction.isHidden = false
                btnAction.setImage(removeImage, for: .normal)
                
                
            }
            
            self.layoutIfNeeded()
        }
    }
    
    @IBAction func btnActionDidTap(_ sender: Any) {
        
        if self.cellType == .photoFolder
        {
            //TODO: check neu photo la nhat thi chuyen sang dam va nguoc lai
            if btnAction.currentImage == unselectedImage
            {
                btnAction.setImage(selectedImage, for: .normal)
            }else
            {
                btnAction.setImage(unselectedImage, for: .normal)
            }
        }
        if self.cellType == .photoPicked
        {
            
        }
        
        if delegate != nil
        {
            self.delegate?.btnActionDidTap(inCell: self)
        }
    }

    
    

}

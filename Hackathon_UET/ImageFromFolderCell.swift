//
//  ImageFromFolderCell.swift
//  Hackathon_UET
//
//  Created by Tuan Vu on 3/11/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit

protocol ImageFromFolderCellDelegate {
    
    func btnActionDidTap()
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if self.cellType == .photoFolder
        {
            btnAction.isHidden = false
            //TODO: set photo x
        }
        if self.cellType == .photoPicked
        {
            btnAction.isHidden = false
            //TODO: set photo nhat.
        }
        // Initialization code
    }
    
    @IBAction func btnActionDidTap(_ sender: Any) {
        
        
        if self.cellType == .photoFolder
        {
            
        }
        if self.cellType == .photoPicked
        {
            //TODO: check neu photo la nhat thi chuyen sang dam va nguoc lai
        }
        
        if delegate != nil
        {
            self.delegate?.btnActionDidTap()
        }
        
        
        
    }
    
    

}

//
//  TagCell.swift
//  Hackathon_UET
//
//  Created by Tuan Vu on 3/11/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit


protocol TagCellDelegate {
    
    func btnDeleteDidTap(cell : TagCell)
}


class TagCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    var delegate : TagCellDelegate?
  
    @IBAction func btnDeleteDidTap(_ sender: Any) {
        self.delegate?.btnDeleteDidTap(cell: self)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }

}

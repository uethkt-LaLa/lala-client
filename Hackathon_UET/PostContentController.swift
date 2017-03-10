//
//  PostContentController.swift
//  Hackathon_UET
//
//  Created by Tuan Vu on 3/11/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit

class PostContentController: UIViewController , ImageForPostViewDelegate {
    
    @IBOutlet weak var txtContent: UITextView!
    
    var pickImageView : ImageForPostView?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configContent()

        // Do any additional setup after loading the view.
    }
    
    private func configContent()
    {
        // config textview
        txtContent.placeholder = kPostContentPlaceholder
        
        // config pick Image
        
        let nib = Bundle.main.loadNibNamed("ImageForPostView", owner: nil, options: nil)
        if let nib = nib
        {
            pickImageView = nib[0] as! ImageForPostView
            pickImageView?.delegate = self
            pickImageView?.frame  = CGRect(x: 0, y: kscreenHeight - 40.0, width:kscreenWidth, height: 200)
            self.view.addSubview(pickImageView!)
        }
        
        
        
        
    }
    
    func btnPickImageDidTap() {
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            
            self.pickImageView?.frame = CGRect(x: 0, y: kscreenHeight - 200, width:kscreenWidth, height: 200)
            
        }, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

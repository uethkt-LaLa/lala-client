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
    

    
    
    var listTag : [String] = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let center = NotificationCenter.default
        center.addObserver(self,
                           selector: #selector(keyboardWillShow(_:)),
                           name: .UIKeyboardWillShow,
                           object: nil)
        
        center.addObserver(self,
                           selector: #selector(keyboardWillHide(_:)),
                           name: .UIKeyboardWillHide,
                           object: nil)
        
        configContent()
        addGes()
        setupNavi()

        // Do any additional setup after loading the view.
    }
    
    func setupNavi()
    {
        let send = UIBarButtonItem(title: "Gửi", style: .plain, target: self, action: #selector(naviButtonCancelDidTap))
        send.setTitleTextAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: 12) ,NSForegroundColorAttributeName : UIColor.white ], for: .normal)
        
        self.navigationItem.rightBarButtonItem = send
        
        let back = UIBarButtonItem(title: "Hủy", style: .plain, target: self, action: #selector(naviButtonSendDidTap))
        back.setTitleTextAttributes([NSFontAttributeName : UIFont.boldSystemFont(ofSize: 19) ,NSForegroundColorAttributeName : UIColor.white ], for: .normal)
        
        self.navigationItem.leftBarButtonItem = back
        
//        self.navigationController?.navigationBar.barTintColor = barTintColor
    }
    
    func naviButtonCancelDidTap()
    {
        self.dismiss(animated: false, completion: nil)
    }
    
    func naviButtonSendDidTap()
    {
        
    }
    
    func keyboardWillShow(_ noti : Notification)
    {
        fullSizePickPhotoView()
    }
    
    func keyboardWillHide(_ noti : Notification)
    {
        
    }
    
    
    
    func swipeDown()
    {
        
        minSizePickPhotoView()
       
    }
    
    private func addGes()
    {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(PostContentController.swipeDown))
        swipeDown.direction = .down
        self.txtContent.addGestureRecognizer(swipeDown)
        
        
        
    }
    
  
    
    private func configContent()
    {
        // config textview
        txtContent.placeholder = kPostContentPlaceholder
        txtContent.autocorrectionType = .no
        
        
        // config pick Image
        
        let nib = Bundle.main.loadNibNamed("ImageForPostView", owner: nil, options: nil)
        if let nib = nib
        {
            pickImageView = nib[0] as! ImageForPostView
            pickImageView?.delegate = self
            pickImageView?.frame  = ImageForPostView.frameFullInRoot!
            self.view.addSubview(pickImageView!)
        }
        
        
        
        
    }
    
    func btnPickImageDidTap() {
        
        fullSizePickPhotoView()
        self.txtContent.endEditing(true)
        
    }
    
    func imgFolderDidTap()
    {
        fullSizePickPhotoView()
    }
    
    func fullSizePickPhotoView()
    {
        
        self.pickImageView?.frame =  ImageForPostView.frameFullInRoot!
        
    }
    func minSizePickPhotoView(){
        
        
        
        self.txtContent.endEditing(true)
        
        self.pickImageView?.frame = ImageForPostView.frameMinInRoot!
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

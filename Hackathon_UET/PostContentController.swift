//
//  PostContentController.swift
//  Hackathon_UET
//
//  Created by Tuan Vu on 3/11/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

enum PostContentControllerType {
    case newPost
    case comment
}

class PostContentController: UIViewController , ImageForPostViewDelegate ,DelegateChooseTag{
    
    @IBOutlet weak var txtContent: UITextView!
    
    var pickImageView : ImageForPostView?
    var listTag : [Tag] = []
    var type : PostContentControllerType?
    var postID : String?
    
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
        let sendImage = #imageLiteral(resourceName: "navigation_button_done_selected")
        let send = UIBarButtonItem(image:sendImage , style: .done, target: self, action: #selector(naviButtonSendDidTap))
        self.navigationItem.rightBarButtonItem = send
        send.tintColor = .white
        
        let back = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(naviButtonCancelDidTap))
        back.setTitleTextAttributes([NSFontAttributeName : UIFont.boldSystemFont(ofSize: 15) ,NSForegroundColorAttributeName : UIColor.white ], for: .normal)
        
        self.navigationItem.leftBarButtonItem = back
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red:38/255, green: 53/255, blue: 66/255, alpha: 1)
    }
    
    func naviButtonCancelDidTap()
    {
        self.dismiss(animated: false, completion: nil)
    }
    
    func naviButtonSendDidTap()
    {
        
        if self.type == .newPost
        {
            let post = Post()
            post.descriptionStr = self.txtContent.text
            post.img_paths = (pickImageView?.listLinkSelected)!
            
            var listTagID : [String] = []
            for tag in self.listTag {
                
                listTagID.append(tag.id)
            }
            post.tag_id = listTagID
            Alamofire.request(kURL+"posts", method: .post, parameters: post.toJSON()).authenticate(user: UltilsUser.kUserName, password: UltilsUser.kPassword).responseJSON { (response) in
                let data = JSON.init(data: response.data!)
                
                self.dismiss(animated: false, completion: nil)
            }
            
        }
        
        if self.type == .comment
        {
            
            let dict :[String:AnyObject] =
                [
                "description" : txtContent.text as AnyObject,
                "image_urls" : (pickImageView?.listLinkSelected)! as AnyObject,
                ]
            Alamofire.request(kURL+"posts/\(self.postID ?? "")/comments", method: .post, parameters: dict).authenticate(user: UltilsUser.kUserName, password: UltilsUser.kPassword).responseJSON { (response) in
                let data = JSON.init(data: response.data!)
                NSLog("\(data)")
                self.dismiss(animated: false, completion: nil)
            }
            
        }
        
   
        
        

        
    }
    
    func doneTouchUp(value: [Tag]) {
        
        self.listTag = value
        pickImageView?.setListTag(value: self.listTag)
        fullSizePickPhotoView()
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
    
    func tagButtonDidTap() {
        
        let choose = ChooseTagNewPostViewController(nibName: "ChooseTagNewPostViewController", bundle: nil)
        choose.listChoose = self.listTag
        choose.delegate = self
        let navi = UINavigationController(rootViewController:choose )
        self.present(navi, animated: false, completion: nil)
    }
    
    func btnDeleteTagDidTap() {
        self.listTag = (pickImageView?.listTag)!
        fullSizePickPhotoView()
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

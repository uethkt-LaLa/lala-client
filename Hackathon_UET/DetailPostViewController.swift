//
//  DetailPostViewController.swift
//  Hackathon_UET
//
//  Created by Anh Tuan on 3/10/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol DetailPostDelegate {
    func likeTouch(index : IndexPath,status : Bool)
    func favTouch(index : IndexPath,status : Bool)
    func disLikeTouch(index : IndexPath, status : Bool)
}

class DetailPostViewController: UIViewController {
    var dataNews : News?
    var index : IndexPath?
    var delegate : DetailPostDelegate?
    var listComment = [Comment]()
    @IBOutlet weak var btnLike : UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func requestComment() {
        Alamofire.request(URL_DEFINE.getComment+"\(dataNews?.id)/"+"comments", method: .post).responseJSON { (response) in
            let data = JSON.init(data: response.data!)
            for item in data.array! {
                let comment = Comment(json: item)
                self.listComment.append(comment)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnLikeTouchUp(_sender : UIButton){
        if delegate != nil {
            delegate?.likeTouch(index: self.index!, status: true)
        }
    }
    @IBAction func btnFAV(_sender : UIButton){
        if delegate != nil {
            delegate?.likeTouch(index: self.index!, status: true)
        }
    }
    @IBAction func btnDisLike(_sender : UIButton){
        if delegate != nil {
            delegate?.disLikeTouch(index: self.index!, status: true)
        }
    }
    @IBAction func backTouchUp(_sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}

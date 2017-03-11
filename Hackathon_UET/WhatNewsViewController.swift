//
//  WhatNewsViewController.swift
//  Hackathon_UET
//
//  Created by Anh Tuan on 3/5/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WhatNewsViewController: BaseViewController {
    @IBOutlet weak var tbl : UITableView!
    var listShow = [News]()
    var urlRequest : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(WhatNewsViewController.reloadData(notification:)), name: NSNotification.Name.init("Menu0"), object: nil)
        tbl.register(UINib.init(nibName: "NewTableViewCell", bundle: nil), forCellReuseIdentifier: "NewTableViewCell")
        tbl.tableFooterView = UIView.init(frame: CGRect.zero)
        tbl.estimatedRowHeight = 100
        tbl.rowHeight = UITableViewAutomaticDimension
        self.loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func loadData() {
        self.showLoadingHUD()
        var url = URL_DEFINE.post_all
        if urlRequest != nil {
            url = urlRequest!
        }
        NSLog("\(UltilsUser.kUserName)")
        NSLog("\(UltilsUser.kPassword)")
        Alamofire.request(url, method: .get, parameters: nil).authenticate(user: UltilsUser.kUserName, password: UltilsUser.kPassword).responseJSON { (response) in
            let jsondata = JSON.init(data: response.data!)
            NSLog("\(jsondata)")
            for item in jsondata.arrayValue {
                let new = News(json: item)
                self.listShow.append(new)
            }
            self.hideLoadingHUD()
            self.tbl.reloadData()
        }
    }
    
    func reloadData(notification : Notification) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setLikeforIndex(index : IndexPath, status : Bool) {
        //http://localhost:5000/api/posts/58b9a2fedaba1d539a2d7128/like
        let idPost = self.listShow[index.row].id
        let item = self.listShow[index.row]
        if status == true { ////like
            item.isLike = true
            item.likes_count = item.likes_count + 1
            Alamofire.request(URL_DEFINE.home_post+"/\(idPost)"+"/like", method: .put, parameters: nil).authenticate(user: UltilsUser.kUserName, password: UltilsUser.kPassword).responseJSON { (response) in
                
            }
        } else if status == false { //unlike
            item.isLike = false
            item.likes_count = item.likes_count - 1
            Alamofire.request(URL_DEFINE.home_post+"/\(idPost)"+"/like", method: .delete, parameters: nil).authenticate(user: UltilsUser.kUserName, password: UltilsUser.kPassword).responseJSON { (response) in
                
            }
        }
        self.listShow[index.row] = item
        tbl.reloadRows(at: [index], with: UITableViewRowAnimation.none)
    }
    
    func setDisLikeForIndex(index : IndexPath, status : Bool){
        let idPost = self.listShow[index.row].id
        let item = self.listShow[index.row]
        if status == true { ////like
            item.isDisLike = true
            item.dislikes_count = item.dislikes_count + 1
            Alamofire.request(URL_DEFINE.home_post+"/\(idPost)"+"/dislike", method: .put, parameters: nil).authenticate(user: UltilsUser.kUserName, password: UltilsUser.kPassword).responseJSON { (response) in
                
            }
        } else if status == false { //unlike
            item.isDisLike = false
            item.dislikes_count = item.dislikes_count - 1
            Alamofire.request(URL_DEFINE.home_post+"/\(idPost)"+"/dislike", method: .delete, parameters: nil).authenticate(user: UltilsUser.kUserName, password: UltilsUser.kPassword).responseJSON { (response) in
            }
        }
        self.listShow[index.row] = item
        tbl.reloadRows(at: [index], with: UITableViewRowAnimation.none)
    }
    func setfavForIndex(index : IndexPath, status : Bool){
        let idPost = self.listShow[index.row].id
        let item = self.listShow[index.row]
        if status == true { ////like
            item.isFollow = true
            Alamofire.request(kURL + "home/following_posts/" + "/\(idPost)", method: .put, parameters: nil).authenticate(user: UltilsUser.kUserName, password: UltilsUser.kPassword).responseJSON { (response) in
                
            }
        } else if status == false { //unlike
            item.isFollow = false
            Alamofire.request(kURL + "home/following_posts/" + "/\(idPost)", method: .delete, parameters: nil).authenticate(user: UltilsUser.kUserName, password: UltilsUser.kPassword).responseJSON { (response) in
                
            }
        }
        self.listShow[index.row] = item
        tbl.reloadRows(at: [index], with: UITableViewRowAnimation.none)
    }
}
extension WhatNewsViewController : UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listShow.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbl.dequeueReusableCell(withIdentifier: "NewTableViewCell", for: indexPath) as! NewTableViewCell
        cell.object = listShow[indexPath.row]
        cell.setData(new: listShow[indexPath.row])
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let detailPost = DetailPostViewController(nibName: "DetailPostViewController", bundle: nil) as! DetailPostViewController
        detailPost.delegate = self
        detailPost.dataNews = self.listShow[indexPath.row]
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.pushViewController(detailPost, animated: true)
    }

}
extension WhatNewsViewController : DetailPostDelegate {
    func likeTouch(index: IndexPath, status: Bool) {
        self.setLikeforIndex(index: index, status: status)
    }
    func favTouch(index: IndexPath, status: Bool) {
        self.setfavForIndex(index: index, status: status)
    }
    func disLikeTouch(index: IndexPath, status: Bool) {
        self.disLikeTouch(index: index, status: status)
    }
}
extension WhatNewsViewController : DelegateNewCell {
    func likeTouchUp(cell : NewTableViewCell , status : Bool){
        let index = tbl.indexPath(for: cell)
        let status = !self.listShow[(index?.row)!].isLike
        self.setLikeforIndex(index: index!, status: status)
        
    }
    func dislikeTouchUp(cell : NewTableViewCell , status : Bool){
        let index = tbl.indexPath(for: cell)
        let status = !self.listShow[(index?.row)!].isDisLike
        self.setDisLikeForIndex(index: index!, status: status)
    }
    func favTouchUp(cell : NewTableViewCell , status : Bool){
        let index = tbl.indexPath(for: cell)
        let status = !self.listShow[(index?.row)!].isFollow
        self.setfavForIndex(index: index!, status: status)
    }
    func commentTouchUp(cell : NewTableViewCell){
        
    }
    func selectImage(cell : NewTableViewCell, index : Int){
        let indexPath = tbl.indexPath(for: cell)
        let slidePhotoVC = SilderPhotoViewController(nibName: "SilderPhotoViewController", bundle: nil)
        slidePhotoVC.listPhotoItem = self.listShow[(indexPath?.row)!].imagePath
        slidePhotoVC.currentIndex = index
        self.present(slidePhotoVC, animated: true, completion: nil)
    }
}

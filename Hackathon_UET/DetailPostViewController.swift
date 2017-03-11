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

class DetailPostViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    var dataNews : News?
    var index : IndexPath?
    var delegate : DetailPostDelegate?
    var listComment = [Comment]()

    
    @IBOutlet weak var tbl: UITableView!
    
    let commentCellId = "commentCellId"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        requestComment()
        configTbl()
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnPostNewCommentDidTap(_ sender: Any) {
        
        let post = PostContentController(nibName: "PostContentController", bundle: nil)
        post.type = .comment
        let navi = UINavigationController(rootViewController: post)
        self.present(navi, animated: false, completion: nil)
    }
    
    
    private func configTbl()
    {
        tbl.delegate = self
        tbl.dataSource = self
        tbl.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: commentCellId)
        tbl.estimatedRowHeight = 200
        
    }
    
    func requestComment() {
        let url = URL_DEFINE.getComment+"\(dataNews!.id)/"+"comments"
        NSLog("\(url)  \(UltilsUser.kUserName)  \(UltilsUser.kPassword)")
        
        Alamofire.request(URL_DEFINE.getComment+"\(dataNews!.id ?? "")/"+"comments", method: .get).authenticate(user: UltilsUser.kUserName, password: UltilsUser.kPassword).responseJSON { (response) in
            let data = JSON.init(data: response.data!)
                NSLog("\(data)")
                for item in data.arrayValue {
                    NSLog("\(item)")
                    let comment = Comment(json: item)
                    print("comment \(comment)")
                    self.listComment.append(comment)
                }
        
           
            self.tbl.reloadData()
        }
        
//        if let path = Bundle.main.path(forResource: "photo", ofType: "json") {
//            do {
//                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
//                let jsonObj = JSON(data: data)
//                if jsonObj != JSON.null {
//                    
//                    for item in jsonObj.array!
//                    {
//                        let comment = Comment(json: item)
//                        self.listComment.append(comment)
//                    }
//                    self.tbl.reloadData()
//                    
//                } else {
//                    print("Could not get json from file, make sure that file contains valid json.")
//                }
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        } else {
//            print("Invalid filename/path.")
//        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return  1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.listComment.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:commentCellId) as! CommentCell
        cell.selectionStyle = .none
        let cmt  = listComment[indexPath.row]
        cell.displayWithComment(cmt)
        cell.delegate = self
        return cell
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
    }


}
extension DetailPostViewController : DelegateCommentCell {
    func touchImage(cell: CommentCell, index: Int) {
        let indexPath = tbl.indexPath(for: cell)
        let slidePhotoVC = SilderPhotoViewController(nibName: "SilderPhotoViewController", bundle: nil)
        slidePhotoVC.listPhotoItem = self.listComment[(indexPath?.row)!].imgPaths
        slidePhotoVC.currentIndex = index
        self.present(slidePhotoVC, animated: true, completion: nil)
    }
}

//
//  MyPostsViewController.swift
//  Hackathon_UET
//
//  Created by Anh Tuan on 3/10/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MyPostsViewController: BaseViewController {
    @IBOutlet weak var tbl : UITableView!
    var listShow = [News]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl.register(UINib.init(nibName: "NewTableViewCell", bundle: nil), forCellReuseIdentifier: "NewTableViewCell")
        tbl.tableFooterView = UIView.init(frame: CGRect.zero)
        tbl.estimatedRowHeight = 100
        tbl.rowHeight = UITableViewAutomaticDimension
        tbl.allowsSelection = false
        self.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadData(notification : Notification) {
        
    }
    func loadData() {
        self.showLoadingHUD()
        var tmp = [News]()
        Alamofire.request(URL_DEFINE.home_post, method: .get, parameters: nil).authenticate(user: UltilsUser.kUserName, password: UltilsUser.kPassword).responseJSON { (response) in
            let jsondata = JSON.init(data: response.data!)
            NSLog("\(jsondata)")
            for item in jsondata.array! {
                let new = News(json: item)
                tmp.append(new)
            }
            self.listShow = tmp
            self.hideLoadingHUD()
            self.tbl.reloadData()
        }
    }

}
extension MyPostsViewController : UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listShow.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewTableViewCell", for: indexPath) as! NewTableViewCell
        cell.object = listShow[indexPath.row]
        cell.setData()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailPost = DetailPostViewController(nibName: "DetailPostViewController", bundle: nil) as! DetailPostViewController
        detailPost.delegate = self
        detailPost.dataNews = self.listShow[indexPath.row]
        self.navigationController?.pushViewController(detailPost, animated: true)
    }
}
extension MyPostsViewController : DetailPostDelegate {
    func likeTouch(index: IndexPath, status: Bool) {
        
    }
    func favTouch(index: IndexPath, status: Bool) {
        
    }
    func disLikeTouch(index: IndexPath, status: Bool) {
        
    }
}

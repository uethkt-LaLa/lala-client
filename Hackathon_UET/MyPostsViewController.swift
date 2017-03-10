//
//  MyPostsViewController.swift
//  Hackathon_UET
//
//  Created by Anh Tuan on 3/10/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit

class MyPostsViewController: UIViewController {
    @IBOutlet weak var tbl : UITableView!
    var listShow = [News]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func requestData() {
        
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
        cell.setData(new: listShow[indexPath.row])
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

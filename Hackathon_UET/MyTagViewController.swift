//
//  MyTagViewController.swift
//  Hackathon_UET
//
//  Created by Anh Tuan on 3/10/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MyTagViewController: UIViewController {
    var listTags = [Tag]()
    var listChoose = [String]()
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var tbl : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl.register(UINib.init(nibName: "TagTableViewCell", bundle: nil), forCellReuseIdentifier: "TagTableViewCell")
        self.requestData()
        self.tbl.tableFooterView = UIView.init(frame: CGRect.zero)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func requestData() {
        self.listChoose.removeAll()
        self.listTags.removeAll()
        Alamofire.request(URL_DEFINE.tagHome, method: .get, parameters: nil).authenticate(user: UltilsUser.kUserName, password: UltilsUser.kPassword).responseJSON { (response) in
            let jsondata = JSON.init(data: response.data!)
            for item in jsondata.arrayValue {
                let tag = Tag.init(json: item)
                tag.select = true
                self.listChoose.append(tag.id)
                self.listTags.append(tag)
            }
            Alamofire.request(URL_DEFINE.tagAll, method: .get, parameters: nil).authenticate(user: UltilsUser.kUserName, password: UltilsUser.kPassword).responseJSON { (response) in
                let jsondata = JSON.init(data: response.data!)
                for item in jsondata.arrayValue {
                    let tag = Tag(json: item)
                    if self.listChoose.contains(tag.id) == false {
                        tag.select = false
                        self.listTags.append(tag)
                    }
                }
            self.tbl.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackTouchUp(_sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
extension MyTagViewController : UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTags.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagTableViewCell", for: indexPath) as! TagTableViewCell
        cell.setData(item: listTags[indexPath.row])
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let tagID = self.listTags[indexPath.row].id
        let whatNews = WhatNewsViewController(nibName: "WhatNewsViewController", bundle: nil)
        whatNews.urlRequest = URL_DEFINE.tagAll + "/\(tagID)/"+"posts"
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.title = "#\(self.listTags[indexPath.row].name)"
        self.navigationController?.pushViewController(whatNews, animated: true)
    }
}
extension MyTagViewController : DelegateTag {
    func chooseTouch(cell: TagTableViewCell) {
        let index = tbl.indexPath(for: cell)
        let item = self.listTags[(index?.row)!]
        if item.select == true {
            item.select = false
            self.listTags[(index?.row)!] = item
            self.tbl.reloadRows(at: [index!], with: UITableViewRowAnimation.fade)
            let id = URL_DEFINE.followOrNotTag+"/\(item.id)"
            NSLog("Hoho\(id)")
            Alamofire.request(URL_DEFINE.followOrNotTag+"\(item.id)", method: .delete, parameters: nil).authenticate(user: UltilsUser.kUserName, password: UltilsUser.kPassword).responseJSON { (response) in
                let json = JSON.init(data: response.data!)
                NSLog("delete \(json)")
            }
        } else {
            item.select = true
            self.listTags[(index?.row)!] = item
            self.tbl.reloadRows(at: [index!], with: UITableViewRowAnimation.fade)
            Alamofire.request(URL_DEFINE.followOrNotTag+"\(item.id)", method: .put, parameters: nil).authenticate(user: UltilsUser.kUserName, password: UltilsUser.kPassword).responseJSON { (response) in
                let json = JSON.init(data: response.data!)
                NSLog("add \(json)")
            }
        }
        
    }
}

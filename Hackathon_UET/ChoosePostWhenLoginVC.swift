//
//  ChoosePostWhenLoginVC.swift
//  Hackathon_UET
//
//  Created by Anh Tuan on 3/11/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ChoosePostWhenLoginVC: UIViewController {
    @IBOutlet weak var tbl : UITableView!
    var listTags = [Tag]()
    var listChoose = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl.register(UINib.init(nibName: "TagTableViewCell", bundle: nil), forCellReuseIdentifier: "TagTableViewCell")
        self.requestData()
        self.tbl.tableFooterView = UIView.init(frame: CGRect.zero)        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func requestData() {
        self.listChoose.removeAll()
        self.listTags.removeAll()
        
        Alamofire.request(URL_DEFINE.tagAll, method: .get, parameters: nil).authenticate(user: UltilsUser.kUserName, password: UltilsUser.kPassword).responseJSON { (response) in
            let jsondata = JSON.init(data: response.data!)
            NSLog("\(jsondata)")
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
    @IBAction func doneTouchUp(_sender : UIButton){
        let mainVC = MainViewController(nibName: "MainViewController", bundle: nil)
        let nav = UINavigationController(rootViewController: mainVC)
        nav.navigationController?.isNavigationBarHidden = true
        nav.navigationController?.setNavigationBarHidden(true, animated: false)
        UIApplication.shared.keyWindow?.rootViewController = nav
        self.dismiss(animated: true, completion: nil)
    }
}
extension ChoosePostWhenLoginVC : UITableViewDataSource,UITableViewDelegate {
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
        let item = self.listTags[indexPath.row]
        if item.select == true {
            item.select = false
            self.listTags[(indexPath.row)] = item
            self.tbl.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            let id = URL_DEFINE.followOrNotTag+"/\(item.id)"
            NSLog("Hoho\(id)")
            Alamofire.request(URL_DEFINE.followOrNotTag+"\(item.id)", method: .delete, parameters: nil).authenticate(user: UltilsUser.kUserName, password: UltilsUser.kPassword).responseJSON { (response) in
                let json = JSON.init(data: response.data!)
                NSLog("delete \(json)")
            }
        } else {
            item.select = true
            self.listTags[(indexPath.row)] = item
            self.tbl.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            Alamofire.request(URL_DEFINE.followOrNotTag+"\(item.id)", method: .put, parameters: nil).authenticate(user: UltilsUser.kUserName, password: UltilsUser.kPassword).responseJSON { (response) in
                let json = JSON.init(data: response.data!)
                NSLog("add \(json)")
            }
        }
    }
}
extension ChoosePostWhenLoginVC : DelegateTag {
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
            Alamofire.request(kURL + "tags/"+"\(item.id)/followers", method: .delete, parameters: nil).authenticate(user: UltilsUser.kUserName, password: UltilsUser.kPassword).responseJSON { (response) in
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
            Alamofire.request(kURL + "tags/"+"\(item.id)/followers", method: .put, parameters: nil).authenticate(user: UltilsUser.kUserName, password: UltilsUser.kPassword).responseJSON { (response) in
                let json = JSON.init(data: response.data!)
                NSLog("delete \(json)")
            }
        }
        
    }
}

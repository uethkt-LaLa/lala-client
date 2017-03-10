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
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var tbl : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl.register(UINib.init(nibName: "TagTableViewCell", bundle: nil), forCellReuseIdentifier: "TagTableViewCell")
        self.requestData()
        self.tbl.tableFooterView = UIView.init(frame: CGRect.zero)        
        // Do any additional setup after loading the view.
    }
    
    func requestData() {
        var tmp = [Tag]()
        Alamofire.request(URL_DEFINE.tagAll, method: .get, parameters: nil).authenticate(user: "admin", password: "123456").responseJSON { (response) in
            let jsondata = JSON.init(data: response.data!)
            for item in jsondata.arrayValue {
                let tag = Tag(json: item)
                self.listTags.append(tag)
            }
            self.tbl.reloadData()
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
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

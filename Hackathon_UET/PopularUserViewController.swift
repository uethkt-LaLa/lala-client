//
//  PopularUserViewController.swift
//  Hackathon_UET
//
//  Created by Anh Tuan on 3/10/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PopularUserViewController: UIViewController {
    @IBOutlet weak var tbl : UITableView!
    var listUser = [PopularUser]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl.tableFooterView = UIView.init(frame: CGRect.zero)
        
        tbl.register(UINib.init(nibName: "PopularTableViewCell", bundle: nil), forCellReuseIdentifier: "PopularTableViewCell")
        self.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func loadData() {
        var tmp = [PopularUser]()
        Alamofire.request(URL_DEFINE.popularUser, method: .get, parameters: nil).responseJSON { (response) in
            let data = JSON.init(data: response.data!)
            for item in data.arrayValue {
                let pu = PopularUser(json: item)
                tmp.append(pu)
            }
            self.listUser = tmp
            self.tbl.reloadData()
        }
    }
}
extension PopularUserViewController : UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listUser.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopularTableViewCell", for: indexPath) as! PopularTableViewCell
        cell.setData(user: self.listUser[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = self.listUser[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = WhatNewsViewController(nibName: "WhatNewsViewController", bundle: nil)
        vc.urlRequest = URL_DEFINE.user_info_id+"\(user.id)"+"/posts"
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        var tmp = [PopularUser]()
        Alamofire.request(URL_DEFINE.popularUser, method: .get, parameters: nil).responseJSON { (response) in
            let data = JSON.init(data: response.data!)
            for item in data.arrayValue {
                let pu = PopularUser(json: item)
                tmp.append(pu)
            }
            self.tbl.reloadData()
            self.listUser = tmp
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagTableViewCell", for: indexPath) as! TagTableViewCell
        cell.setData(user: self.listUser[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

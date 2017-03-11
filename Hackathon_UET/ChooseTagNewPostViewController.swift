//
//  ChooseTagNewPostViewController.swift
//  Hackathon_UET
//
//  Created by Anh Tuan on 3/11/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol DelegateChooseTag {
    func doneTouchUp(value: [Tag])
}

class ChooseTagNewPostViewController: UIViewController {
    @IBOutlet weak var tbl : UITableView!
    var listTags = [Tag]()
    var listChoose = [Tag]()
    var result = [Tag]()
    var delegate : DelegateChooseTag?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavi()
        tbl.register(UINib.init(nibName: "TagTableViewCell", bundle: nil), forCellReuseIdentifier: "TagTableViewCell")
        self.requestData()
        self.tbl.tableFooterView = UIView.init(frame: CGRect.zero)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.edgesForExtendedLayout = []
    }
    
    func setupNavi()
    {
        let sendImage = #imageLiteral(resourceName: "navigation_button_done_selected")
        let send = UIBarButtonItem(image:sendImage , style: .done, target: self, action: #selector(naviButtonSendDidTap))
        self.navigationItem.rightBarButtonItem = send
        send.tintColor = .white
        
        let back = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(naviButtonCancelDidTap))
        back.setTitleTextAttributes([NSFontAttributeName : UIFont.boldSystemFont(ofSize: 15) ,NSForegroundColorAttributeName : UIColor.white ], for: .normal)
        
        self.navigationItem.leftBarButtonItem = back
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red:38/255, green: 53/255, blue: 66/255, alpha: 1)
    }
    
    func naviButtonCancelDidTap()
    {
        self.dismiss(animated: false, completion: nil)
    }
    
    func naviButtonSendDidTap()
    {
        self.result.removeAll()
        for item in self.listTags {
            if item.select == true {
                result.append(item)
            }
        }
        if delegate != nil {
            delegate?.doneTouchUp(value: result)
        }
        
        dismiss(animated: false, completion: nil)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func requestData() {
        self.listTags.removeAll()       
        Alamofire.request(URL_DEFINE.tagAll, method: .get, parameters: nil).authenticate(user: UltilsUser.kUserName, password: UltilsUser.kPassword).responseJSON { (response) in
            let jsondata = JSON.init(data: response.data!)
            for item in jsondata.arrayValue {
                let tag = Tag(json: item)
                for item2 in self.listChoose {
                    if item2.id == tag.id {
                        tag.select = true
                        break
                    }
                }
                self.listTags.append(tag)
            }
            self.tbl.reloadData()
        }
    }
    
    @IBAction func doneTouchUp(_sender : UIButton){
       
    }
}
extension ChooseTagNewPostViewController : UITableViewDataSource,UITableViewDelegate {
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
            self.listTags[indexPath.row] = item
            self.tbl.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
            
        } else {
            item.select = true
            self.listTags[indexPath.row] = item
            self.tbl.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
        }
    }
}
extension ChooseTagNewPostViewController : DelegateTag {
    func chooseTouch(cell: TagTableViewCell) {
        let index = tbl.indexPath(for: cell)
        let item = self.listTags[(index?.row)!]
        if item.select == true {
            item.select = false
            self.listTags[(index?.row)!] = item
            self.tbl.reloadRows(at: [index!], with: UITableViewRowAnimation.none)
            
        } else {
            item.select = true
            self.listTags[(index?.row)!] = item
            self.tbl.reloadRows(at: [index!], with: UITableViewRowAnimation.none)
        }
        
    }
}


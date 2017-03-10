//
//  MenuViewController.swift
//  Hackathon_UET
//
//  Created by Anh Tuan on 3/5/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit

class MenuObj {
    var titleName : String
    var imgPath : String
    init(titleName : String, imgPath : String) {
        self.titleName = titleName
        self.imgPath = imgPath
    }
}

class MenuViewController: UIViewController {
    @IBOutlet weak var tbl : UITableView!
    var whatNews : WhatNewsViewController?
    var favVC : FavoritesPostViewController?
    var myPostVC : MyPostsViewController?
    var listMenu = [MenuObj]()
    var myTagVC : MyTagViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        whatNews = WhatNewsViewController(nibName: "WhatNewsViewController", bundle: nil)
        favVC = FavoritesPostViewController(nibName: "FavoritesPostViewController", bundle: nil)
        myPostVC = MyPostsViewController(nibName: "MyPostsViewController", bundle: nil)
        myTagVC = MyTagViewController(nibName: "MyTagViewController", bundle: nil)
        listMenu.append(MenuObj(titleName: "What's New", imgPath: ""))
        listMenu.append(MenuObj(titleName: "Favorite Posts", imgPath: ""))
        listMenu.append(MenuObj(titleName: "My Posts", imgPath: ""))
        listMenu.append(MenuObj(titleName: "My Tag", imgPath: ""))
        listMenu.append(MenuObj(titleName: "My Profile", imgPath: ""))
        tbl.register(UINib.init(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
        tbl.tableFooterView = UIView.init(frame: CGRect.zero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension MenuViewController : UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMenu.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
        cell.setData(obj: self.listMenu[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MainViewController.sharedInstance.slideMenu?.closeLeft()
        switch indexPath.row {
        case 0:
            MainViewController.sharedInstance.slideMenu?.mainViewController = whatNews
            NotificationCenter.default.post(name: NSNotification.Name.init("MenuWhatNews"), object: nil)
        case 1:
            MainViewController.sharedInstance.slideMenu?.mainViewController = favVC
            NotificationCenter.default.post(name: NSNotification.Name.init("Favorites"), object: nil)
        case 2:
            MainViewController.sharedInstance.slideMenu?.mainViewController = myPostVC
            NotificationCenter.default.post(name: NSNotification.Name.init("PostVC"), object: nil)
        case 3:
            MainViewController.sharedInstance.slideMenu?.mainViewController = myTagVC
            NotificationCenter.default.post(name: NSNotification.Name.init("PostVC"), object: nil)        
        default:
            break
        }
    }
}

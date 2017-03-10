//
//  MainViewController.swift
//  Hackathon_UET
//
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import Alamofire

class MainViewController: UIViewController {
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var mainView : UIView!
    static let sharedInstance = MainViewController()
    var slideMenu : SlideMenuController?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        let menuVC = MenuViewController(nibName: "MenuViewController", bundle: nil)
        let receiveVC = WhatNewsViewController(nibName: "WhatNewsViewController", bundle: nil)
        let slideMenu = SlideMenuController(mainViewController: receiveVC, leftMenuViewController: menuVC)
        slideMenu.view.frame = mainView.bounds
        mainView.addSubview(slideMenu.view)
        addChildViewController(slideMenu)
        slideMenu.didMove(toParentViewController: self)
        MainViewController.sharedInstance.slideMenu = slideMenu
        MainViewController.sharedInstance.lblTitle = self.lblTitle
        self.lblTitle.text = "Đơn Nhận"        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnMenuTouchUpInSide(_ sender: Any) {
        if (MainViewController.sharedInstance.slideMenu?.slideMenuController()?.isLeftOpen())! {
            MainViewController.sharedInstance.slideMenu?.slideMenuController()?.closeLeft()
        } else {
            MainViewController.sharedInstance.slideMenu?.slideMenuController()?.openLeft()
        }
    }
    

}

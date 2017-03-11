//
//  SettingViewController.swift
//  Hackathon_UET
//
//  Created by Anh Tuan on 3/11/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit
import CarbonKit
import Alamofire
import SwiftyJSON

class SettingViewController: UIViewController {
    @IBOutlet weak var imgAva : UIImageView!
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var contentView : UIView!
    var tabsName = [String]()
    var urlID : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        imgAva.clipsToBounds = true
        imgAva.cornerRadius = imgAva.frame.width / 2
        
        requestInfo()
        initCarbonTabs()
    }
    
    func requestInfo() {
        let id = UltilsUser.userId
        if urlID == nil {
            urlID = id
        }
        Alamofire.request(URL_DEFINE.user_info_id + "\(urlID!)", method: .get, parameters: nil).authenticate(user: UltilsUser.userId, password: UltilsUser.kPassword).responseJSON { (response) in
            let data = JSON.init(data: response.data!)
            NSLog("\(data)")
            let display_name = data["display_name"].stringValue
            let image_url = data["image_url"].stringValue
            self.imgAva.sd_setImage(with: URL.init(string: image_url), placeholderImage: kImagePlaceHoler)
            self.lblName.text = display_name
        }
    }
    
    func initCarbonTabs() {
        tabsName.append("My Tag")
        let carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: tabsName, delegate: self)
        carbonTabSwipeNavigation.insert(intoRootViewController: self, andTargetView: contentView)
        carbonTabSwipeNavigation.setTabBarHeight(40)
        carbonTabSwipeNavigation.setIndicatorHeight(2)
        carbonTabSwipeNavigation.carbonSegmentedControl?.backgroundColor = UIColor.init(rgba: "#FFFFFF")
        carbonTabSwipeNavigation.setNormalColor(UIColor.init(rgba: "#00A25E"), font: UIFont.systemFont(ofSize: 13))
        carbonTabSwipeNavigation.setNormalColor(UIColor.init(rgba: "#007D01"), font: UIFont.systemFont(ofSize: 14))
        for i in 0..<tabsName.count {
            carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(UIScreen.main.bounds.width , forSegmentAt: i)
        }
    }
    
    @IBAction func dismiss(_sender : UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension SettingViewController : CarbonTabSwipeNavigationDelegate {
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, didMoveAt index: UInt) {
    }
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        switch index {
        case 0:
            let vc = MyTagViewController(nibName: "MyTagViewController", bundle: nil)
            return vc
        default:
            let vc = MyTagViewController(nibName: "MyTagViewController", bundle: nil)
            return vc
        }
    }
}


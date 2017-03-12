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

class SettingViewController: BaseViewController {
    @IBOutlet weak var imgAva : UIImageView!
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var contentView : UIView!
    @IBOutlet weak var lblFollower : UILabel!
    @IBOutlet weak var lblLike : UILabel!
    @IBOutlet weak var lblCountFLPost : UILabel!
    @IBOutlet weak var lblCountFLTag : UILabel!
    @IBOutlet weak var btnChat : UIButton!
    var tabsName = [String]()
    var urlID : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        imgAva.clipsToBounds = true
        imgAva.cornerRadius = imgAva.frame.width / 2
        
        requestInfo()
        initCarbonTabs()
    }
    override func viewWillAppear(_ animated: Bool) {
        if urlID == nil {
            btnChat.isEnabled = false
        } else {
            btnChat.setTitle("   Chat with me   ", for: UIControlState.normal)
            btnChat.isEnabled = true
        }
    }
    
    func requestInfo() {
        let id = UltilsUser.userId
        if urlID == nil {
            urlID = id
        }
        self.showLoadingHUD()
        Alamofire.request(URL_DEFINE.user_info_id + "\(urlID!)", method: .get, parameters: nil).authenticate(user: UltilsUser.userId, password: UltilsUser.kPassword).responseJSON { (response) in
            let data = JSON.init(data: response.data!)
            self.hideLoadingHUD()
            NSLog("Info \(data)")
            let display_name = data["display_name"].stringValue
            let image_url = data["image_url"].stringValue
            let flTag = data["following_tags"].arrayValue
            
            self.lblCountFLTag.text = "follow \(flTag.count) tags"
            let flPost = data["following_posts"].arrayValue
            self.lblCountFLPost.text = "follow \((flPost.count)) posts"
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
    
    @IBAction func btnChatTouchUp(_ sender : UIButton) {
        let idThangkia = urlID
    }
}

extension SettingViewController : CarbonTabSwipeNavigationDelegate {
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, didMoveAt index: UInt) {
    }
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        switch index {
        case 0:
            let id = UltilsUser.userId
            if urlID == nil {
                urlID = id
            }
            let vc = MyTagViewController(nibName: "MyTagViewController", bundle: nil)
            vc.url = kURL + "users/\(urlID)/following_tags"
            return vc
        default:
            let vc = MyTagViewController(nibName: "MyTagViewController", bundle: nil)
            return vc
        }
    }
}


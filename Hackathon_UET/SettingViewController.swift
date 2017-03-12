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
    @IBOutlet weak var btnLogOut : UIButton!
    @IBOutlet weak var btnFollow : UIButton!
    var tabsName = [String]()
    var urlID : String?
    var method : HTTPMethod = .post
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        imgAva.clipsToBounds = true
        imgAva.cornerRadius = imgAva.frame.width / 2
        
        initCarbonTabs()
    }
    override func viewWillAppear(_ animated: Bool) {
        requestInfo()
        if urlID == nil {
            btnChat.isEnabled = false
            heightConstraint.constant = 40
            btnLogOut.isHidden = false
        } else {
            heightConstraint.constant = 0
            btnLogOut.isHidden = true
            btnChat.setTitle("   Chat with me   ", for: UIControlState.normal)
            btnChat.isEnabled = true
        }
        self.loadFollowOrNot()
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
    
    func loadFollowOrNot() {
        let id = UltilsUser.userId
        btnFollow.isHidden = false
        if ((urlID == nil) || (urlID == id)) {
            urlID = id
            btnFollow.isHidden = true
        }
        var followOrNot = true
        Alamofire.request(URL_DEFINE.home , method: .get, parameters: nil).authenticate(user: UltilsUser.userId, password: UltilsUser.kPassword).responseJSON { (response) in
            let data = JSON.init(data: response.data!)
            NSLog("Info \(data)")
            let followings = data["followings"].arrayValue
            for item in followings {
                let val = item.stringValue
                if val == self.urlID {
                    followOrNot = true //dang follow
                    break
                }
            }
            self.method = HTTPMethod.put
            if followOrNot == true {
                self.method = HTTPMethod.delete
            }
            if self.method == .put {
                self.btnFollow.setImage(UIImage.init(named: "Follow"), for: UIControlState.normal)
            } else {
                self.btnFollow.setImage(UIImage.init(named: "Followed"), for: UIControlState.normal)
            }
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
    
    @IBAction func logoutTouchUp(_sender : UIButton){
        UltilsUser.kPassword = ""
        UltilsUser.kUserName = ""
        UltilsUser.userId = ""
        
        let mainVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
        UIApplication.shared.keyWindow?.rootViewController = mainVC
    }
    
    @IBAction func followOrUnfollow(_ sender : UIButton){
        if self.method == .put {
            self.btnFollow.setImage(UIImage.init(named: "Followed"), for: UIControlState.normal)
            self.method = .delete
        } else {
            self.btnFollow.setImage(UIImage.init(named: "Follow"), for: UIControlState.normal)
            self.method = .put
        }
        Alamofire.request(kURL+"home/following_people/\(self.urlID!)", method: self.method, parameters: nil).authenticate(user: UltilsUser.kUserName, password: UltilsUser.kPassword).responseJSON { (response) in
            let data = JSON.init(data: response.data!)
            NSLog("Follow \(data)")
        }
        Alamofire.request(kURL+"users/" + "\(self.urlID!)/followers", method: self.method, parameters: nil).authenticate(user: UltilsUser.kUserName, password: UltilsUser.kPassword).responseJSON { (response) in
            let data = JSON.init(data: response.data!)
            NSLog("Follow hihi \(data)")
        }
        
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
            if ((urlID == nil) || (urlID == UltilsUser.userId)) {
                vc.isChoose = true
            } else {
                vc.isChoose = false
            }
            return vc
        default:
            let vc = MyTagViewController(nibName: "MyTagViewController", bundle: nil)
            return vc
        }
    }
}


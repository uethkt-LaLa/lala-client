//
//  LoginViewController.swift
//  Hackathon_UET
//
//  Created by Anh Tuan on 3/10/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit
import ToastSwiftFramework
import Alamofire
import FBSDKLoginKit
import FBSDKCoreKit
import SwiftyJSON


class LoginViewController: UIViewController {
    @IBOutlet weak var txtUserName : UITextField!
    @IBOutlet weak var txtUserPass : UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnLoginTouchUp(_ sender : UIButton){
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["public_profile"], from: self) { (facebookResult, facebookError) in
            if facebookError != nil {
                
            } else if (facebookResult?.isCancelled)! {
                
            } else {
                FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id,email,name"]).start(completionHandler: { (connect, result, error) in
                    NSLog("\(result!)")
                    let tmp = result! as! Dictionary<String, String>
                    let id = tmp["id"] ?? ""
                    let name = tmp["name"] ?? ""
                    let email = tmp["email"] ?? ""//facebook id, username, email
                    let password = UUID().uuidString
                    var token = ""
                    //check is in DB 
                    
                        //http://localhost:5000/api/users/fb_id/1789172604736580
                        Alamofire.request(URL_DEFINE.user_info_id+"fb_id/"+"\(id)", method: .get, parameters: nil).responseJSON(completionHandler: { (response) in
                            let data = JSON.init(data: response.data!)
                            if data != nil && data.arrayValue.count != 0 {
                                
                                let data2 = data.arrayValue[0]
                                let id = data2["_id"].stringValue
                                let username = data2["username"].stringValue ?? ""
                                let password = data2["plain_pass"].stringValue ?? ""
                                UltilsUser.userId = id
                                UltilsUser.kUserName = username
                                UltilsUser.kPassword = password
                                
                                UserDefaults.standard.setValue(id, forKey: "userId")
                                UserDefaults.standard.setValue(username, forKey: "username")
                                UserDefaults.standard.setValue(password, forKey: "password")
                                
                                let mainVC = MainViewController(nibName: "MainViewController", bundle: nil)
                                let nav = UINavigationController(rootViewController: mainVC)
                                nav.navigationController?.isNavigationBarHidden = true
                                nav.navigationController?.setNavigationBarHidden(true, animated: false)
                                UIApplication.shared.keyWindow?.rootViewController = nav

                            } else {
                                if FBSDKAccessToken.current() != nil {
                                    token = FBSDKAccessToken.current().tokenString
                                }
                                let param : [String : String] = ["username" : id, //thanh username
                                                                 "password" : password,
                                                                 "display_name" : name,
                                                                 "email" : email,
                                                                 "fb_id": id,
                                                                 "token" : token,
                                                                 "image_url" : "https://graph.facebook.com/\(id)/picture?type=large"]
                                Alamofire.request(URL_DEFINE.kURLRegis, method: .post, parameters: param).responseJSON(completionHandler: { (response) in
                                    let data = JSON.init(data: response.data!)
                                    NSLog("\(data)")
                                    let data2 = data["data"]
                                    let id = data2["_id"].stringValue
                                    let username = data2["username"].stringValue ?? ""
                                    UltilsUser.userId = id
                                    UltilsUser.kUserName = username
                                    UltilsUser.kPassword = password
                                    
                                    UserDefaults.standard.setValue(id, forKey: "userId")
                                    UserDefaults.standard.setValue(username, forKey: "username")
                                    UserDefaults.standard.setValue(password, forKey: "password")
                                    
//                                    let mainVC = MainViewController(nibName: "MainViewController", bundle: nil)
//                                    let nav = UINavigationController(rootViewController: mainVC)
//                                    nav.navigationController?.isNavigationBarHidden = true
//                                    nav.navigationController?.setNavigationBarHidden(true, animated: false)
//                                    UIApplication.shared.keyWindow?.rootViewController = nav
                                })
                            }
                        })
                        return
                        //check on DB if not
                    
                })
            }
        }
    }
    @IBAction func btnRegisterTouchUp(_ sender : UIButton){
        
    }
}

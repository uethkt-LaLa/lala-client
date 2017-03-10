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
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (facebookResult, facebookError) in
            if facebookError != nil {
                
            } else if (facebookResult?.isCancelled)! {
                
            } else {
                FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name"]).start(completionHandler: { (connect, result, error) in
                    NSLog("\(result)")
                })
            }
        }
    }
    @IBAction func btnRegisterTouchUp(_ sender : UIButton){
        
    }
}

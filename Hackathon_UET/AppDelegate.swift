//
//  AppDelegate.swift
//  Hackathon_UET
//
//  Created by Anh Tuan on 3/5/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import FBSDKLoginKit
import FirebaseDatabase
import FirebaseCore

let kUserId = "58ba468ddfae86239b973adc"
let kURL = "https://lala-test.herokuapp.com/api/"
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FIRApp.configure()
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let newpost = NewPostViewController(nibName: "NewPostViewController", bundle: nil)
        let mainVC = MainViewController(nibName: "MainViewController", bundle: nil)
        
        let nav = UINavigationController(rootViewController: mainVC)
        nav.navigationController?.isNavigationBarHidden = true
        nav.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let pickerView = PicktureViewController(nibName: "PicktureViewController", bundle: nil)
        let login = LoginViewController(nibName: "LoginViewController", bundle: nil)
        let myTag = MyTagViewController(nibName: "MyTagViewController", bundle: nil)
        

        

        let userId = UserDefaults.standard.value(forKey: "userId")
        if userId != nil {
            UltilsUser.userId = userId as? String ?? ""
        }
        
        let userna = UserDefaults.standard.value(forKey: "username")
        if userna != nil {
            UltilsUser.kUserName = userna as? String ?? ""
        }
        
        let pass = UserDefaults.standard.value(forKey: "password")
        if pass != nil {
            UltilsUser.kPassword = pass as? String ?? ""
        }
//        UserDefaults.standard.setValue(id, forKey: "userId")
//        UserDefaults.standard.setValue(username, forKey: "username")
//        UserDefaults.standard.setValue(password, forKey: "password")

        
        if UltilsUser.userId != "" {
            self.window?.rootViewController = nav
        } else {
            self.window?.rootViewController = login
        }
        
    
        
        self.window?.makeKeyAndVisible()
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
}


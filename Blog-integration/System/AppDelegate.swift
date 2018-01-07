//
//  AppDelegate.swift
//  Blog-integration
//
//  Created by Vlad Krut on 06.01.2018.
//  Copyright © 2018 Vlad Krut. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setKeyboardManager()
        
        let vc = IntroVC()
        
        let navigationVC = UINavigationController(rootViewController: vc)
        navigationVC.setNavigationBarHidden(true, animated: false)
        
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func setKeyboardManager() {
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
    }


}


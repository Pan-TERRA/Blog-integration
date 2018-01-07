//
//  AuthorizationManager.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 04.10.2017.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import Foundation
import FirebaseAuthUI

class AuthorizationManager: NSObject {
    
    static let shared: AuthorizationManager = {
        let manager = AuthorizationManager()
        
        FUIAuth.defaultAuthUI()?.delegate = manager
        
        return manager
    }()
    
    var userProfile: User?
    
    func login(on vc: BasicVC) {
        vc.present(FUIAuth.defaultAuthUI()!.authViewController(), animated: true, completion: nil)
    }

    func logout() {
        
        UserDefaultsManager.default.clearAllDefaults()
        
        userProfile = nil
        
        try? FUIAuth.defaultAuthUI()?.signOut()
        
        let vc = IntroVC()
        let navigationVC = UINavigationController(rootViewController: vc)
        navigationVC.setNavigationBarHidden(true, animated: false)
        
        UIApplication.shared.keyWindow?.set(toRootViewController: navigationVC)
    }
}

extension AuthorizationManager: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        
        if user != nil {
            
            userProfile = user
            
            let vc = MainVC()
            let navigationVC = UINavigationController(rootViewController: vc)
            navigationVC.setNavigationBarHidden(true, animated: false)
            
            UIApplication.shared.keyWindow?.set(toRootViewController: navigationVC)
            
        } else {
            print(error?.localizedDescription ?? "")
        }
    }
    
    
}



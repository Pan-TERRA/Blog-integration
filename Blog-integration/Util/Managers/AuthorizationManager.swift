//
//  AuthorizationManager.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 04.10.2017.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import Foundation
import SwiftyJSON

enum AuthorizationType: String {
    case facebook = "login/check-facebook"
//    case google = "login/check-google"
}

class AuthorizationManager {
    
    static let shared = AuthorizationManager()

    /// Now unused. Only for authorization without FB SDK
//    func loginWithSocials(type: AuthorizationType, code: String, completionHandler: @escaping (SponsorhusetError?)->()) {
//
//        APIManager().loginWithSocials(type: type, code: code, success: { (response) in
//            self.parseTokensWithResponse(response)
//            self.getCurrentUserProfile(completionHandler: completionHandler)
//
//        }) { (error) in
//            DispatchQueue.main.async {
//                completionHandler(error)
//            }
//        }
//    }
    
    func loginManually(email: String, password: String, completionHandler: @escaping (SponsorhusetError?)->()) {
        
        let form = LoginForm()
        form.email = email
        form.password = password
        
        APIManager().login(form: form, success: { response in
            self.saveCurrentUserProfile(response: response)
            DispatchQueue.main.async {
                completionHandler(nil)
            }
        }, failure: { error in
            DispatchQueue.main.async {
                completionHandler(error)
            }
        })

    }
    
//    func register(form: RegistrationForm, completionHandler: @escaping (Error?, Int?)->()) {
//
//        APIManager().registerUser(data: form, success: { (response) in
//            print(response)
//            completionHandler(nil, nil)
//
//        }) { (error, code) in
//            DispatchQueue.main.async {
//                completionHandler(error, code)
//            }
//        }
//    }
    
    
    func saveCurrentUserProfile(response: Any) {
        
        if let currentUser = ProfileModel(JSONString: JSONString(data: response)) {
            APIModels.shared.userProfile = currentUser
            
            UserDefaultsManager.default.writeValue(currentUser.userID, forKey: .kUserID)
        }
    }
    
    func logout() {
        
        UserDefaultsManager.default.clearAllDefaults()
        
        APIModels.shared.userProfile = nil
        
        // Clear facebook cookies
        let storage = HTTPCookieStorage.shared
        for cook in storage.cookies! {
            let domainName: NSString = cook.domain as NSString
            let domainRange = domainName.range(of: "facebook")
            if domainRange.length > 0 {
                storage.deleteCookie(cook)
            }
        }
        
        let vc = IntroVC()
        let navigationVC = UINavigationController(rootViewController: vc)
        navigationVC.setNavigationBarHidden(true, animated: false)
        
        UIApplication.shared.keyWindow?.set(toRootViewController: navigationVC)
    }
}

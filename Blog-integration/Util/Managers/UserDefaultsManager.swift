//
//  UserDefaultsManager.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 04.10.2017.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import Foundation

enum UserDefaultKeys: String {
    case kDeviceToken = "DeviceToken"
    case kFacebookToken = "FacebookToken"
    case kUserToken = "UserToken"
    case kRefreshToken = "RefreshToken"
    case kUserID = "UserID"
    case kPrefferedCategoryID = "PrefferedCategoryID"
}

class UserDefaultsManager {
    
    static let `default` = UserDefaultsManager()
    
    func getValue<T>(valueType: T.Type, forKey: UserDefaultKeys) -> T? {
        guard let value = UserDefaults.standard.value(forKey: forKey.rawValue) as? T else { return nil }
        return value
    }
    
    func writeValue<T>(_ value: T?, forKey: UserDefaultKeys) {
        UserDefaults.standard.set(value, forKey: forKey.rawValue)
    }
    
    func clearAllDefaults() {
        
        let appDomain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: appDomain)
        UserDefaults.standard.synchronize()
    }
}

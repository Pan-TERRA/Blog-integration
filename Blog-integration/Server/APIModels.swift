//
//  APIModels.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 04.10.2017.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import Foundation

class APIModels {
    
    static let shared: APIModels = {
        let models = APIModels()
        
        return models
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func clubDidChange(_ notification: Notification) {
        
        APIManager().getCurrentUser(success: { response in
            AuthorizationManager.shared.saveCurrentUserProfile(response: response)
        }, failure: { error in
            print("\nAPIModels. clubDidChange FAILURE!:\n\(error.localizedDescription)\n")
        })
    }
    
    var userProfile: ProfileModel?
}

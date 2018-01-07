//
//  Profile.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 04.10.2017.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import ObjectMapper

class ProfileModel: Mappable {
    
    var uid: String?
    var nickname: String?
    var email: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        uid <- map["id"]
        nickname <- map["nickname"]
        email <- map["email"]
    }
    
}

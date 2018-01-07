//
//  ProfileForm.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 04.10.2017.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import ObjectMapper

class ProfileForm: Mappable {
    
    var firstname: String?
    var lastname: String?
    var phone: String?
    var password: String?
    
    init() {}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        firstname <- map["first"]
        lastname <- map["last"]
        phone <- map["mobile"]
        password <- map["pass"]
    }
}




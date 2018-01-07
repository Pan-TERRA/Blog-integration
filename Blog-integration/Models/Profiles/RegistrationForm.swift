//
//  RegistrationForm.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 04.10.2017.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import ObjectMapper

class RegistrationForm: Mappable {
    
    var nickname: String?
    var email: String?
    var password: String?
    
    init() {}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        nickname <- map["nickname"]
        email <- map["email"]
        password <- map["password"]
    }
}



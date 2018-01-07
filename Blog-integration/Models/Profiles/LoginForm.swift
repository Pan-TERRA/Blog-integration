//
//  LoginForm.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 28.11.2017.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import ObjectMapper

class LoginForm: Mappable {
    
    var email: String?
    var password: String?
    
    init() {}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        email <- map["email"]
        password <- map["password"]
    }
}

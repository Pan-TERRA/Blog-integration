//
//  Profile.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 04.10.2017.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import ObjectMapper

class ProfileModel: Mappable {
    
    var userID: Int?
    var firstName: String?
    var lastName: String?

    var email: String?
    
    var birthdate: String?
    var facebookID: Int?
    
    var phone: String?
    
    var clubID: Int?
    var clubName: String?
    
    var balance: Int?
    var availableBalance: Int?
    
    var isPanelist: Bool?
    
    var hash: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        userID <- map["id"]
        firstName <- map["first"]
        lastName <- map["last"]
        
        email <- map["email"]
        birthdate <- map["birthdate"] // birthdate = "2000-01-01";
        
        facebookID <- map["fb_id"]
        
        phone <- map["mobile"]
        
        clubID <- map["club_id"]
        clubName <- map["club_name"]
        
        balance <- map["balance"]
        availableBalance <- map["available"]
        
        isPanelist <- map["is_panelist"]
        
        hash <- map["hash"]
    }
    
    var fullName: String {
        get {
            var name = ""
            if let firstName = firstName {
                name = firstName
            }
            if let lastName = lastName {
                name += " \(lastName)"
            }
            return name
        }
    }
    
//    func setAvatarOnView(_ imageView: UIImageView) {
//        
//        if let avatarPath = thumbAvatarURL,
//            let url = URL(string: MainAPIUrl + avatarPath) {
//            imageView.af_setImage(withURL: url, placeholderImage: UIImage(named: "defaultAvatar")!)
//        }
//    }
}

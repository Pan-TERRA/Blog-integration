//
//  PostModel.swift
//  Blog-integration
//
//  Created by Vlad Krut on 07.01.2018.
//  Copyright © 2018 Vlad Krut. All rights reserved.
//

import ObjectMapper

class PostModel: Mappable {
    
    var id: String?
    var text: String?
    var date: Date?
    
    var authorName: String?
    var userID: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        id <- map["id"]
        text <- map["text"]
        date <- (map["date"], DateTransform())
        
        userID <- map["user_id"]
        authorName <- map["author_name"]
    }
    
}


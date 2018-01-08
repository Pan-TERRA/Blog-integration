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
    
    init() {}
    required init?(map: Map) {
        if map.JSON["id"] == nil {
            return nil
        }
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        text <- map["text"]
        date <- (map["date"], DateTransform())
        
        userID <- map["user_id"]
        authorName <- map["author_name"]
    }
    
}


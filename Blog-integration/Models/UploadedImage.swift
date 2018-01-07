//
//  UploadedImage.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 04.10.2017.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import ObjectMapper

class UploadedImage: Mappable {
    
    var imageID: Int?
    var path: String?
    var thumb: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        imageID <- map["id"]
        path <- map["path"]
        thumb <- map["thumb"]
    }
}


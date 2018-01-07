//
//  DateTransform.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 04.10.2017.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import ObjectMapper

class DateTransform: TransformType {
    
    public typealias Object = Date
    public typealias JSON = String
    
    public init(format: String? = nil) {
        self.dateFormat = format
    }
    
    private var dateFormat: String?
    
    open func transformFromJSON(_ value: Any?) -> Date? {
        
        guard let string = value as? String else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat ?? "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: string)
    }
    
    open func transformToJSON(_ value: Date?) -> String? {
        return nil
    }
}


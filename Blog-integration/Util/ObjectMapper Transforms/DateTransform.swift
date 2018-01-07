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
    
    open func transformFromJSON(_ value: Any?) -> Date? {
        
        guard let string = value as? String else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        
        return dateFormatter.date(from: string)
    }
    
    open func transformToJSON(_ value: Date?) -> String? {
        return nil
    }
}


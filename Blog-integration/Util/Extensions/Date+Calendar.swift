
//
//  Date+Calendar.swift
//  Blog-integration
//
//  Created by Vlad Krut on 07.01.2018.
//  Copyright © 2018 Vlad Krut. All rights reserved.
//

import Foundation

extension Date {
    var day: Int { return Calendar.current.component(.day, from: self) }
    var month: Int { return Calendar.current.component(.month, from: self) }
    var year: Int { return Calendar.current.component(.year, from: self) }
    
    var monthName: String { return DateFormatter().monthSymbols[month - 1] }
}

//
//  Constants.swift
//  Blog-integration
//
//  Created by Vlad Krut on 06.01.2018.
//  Copyright © 2018 Vlad Krut. All rights reserved.
//

import Foundation

let MainAPIUrl = ""

func printCurrentTag() {
    print("Runtime. Git tag: \(getGitTag() ?? "null")")
}

func getGitTag() -> String? {
    guard let path = Bundle.main.path(forResource: "GitTag", ofType: "plist"), let plist = NSDictionary(contentsOfFile: path), let tag = plist["GitTag"] as? String else {
        return nil
    }
    
    return tag
}

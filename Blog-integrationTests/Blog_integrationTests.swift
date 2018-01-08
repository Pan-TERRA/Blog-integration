//
//  Blog_integrationTests.swift
//  Blog-integrationTests
//
//  Created by Vlad Krut on 06.01.2018.
//  Copyright © 2018 Vlad Krut. All rights reserved.
//

import XCTest
@testable import Blog_integration

class Blog_integrationTests: XCTestCase {
    
    var blogVC: MyBlogVC?
    
    override func setUp() {
        super.setUp()
        
        blogVC = MyBlogVC()
    }
    
    override func tearDown() {
        
        blogVC = nil
        
        super.tearDown()
    }
    
    func testMappableVC() {
        
        XCTAssert(blogVC!.mappables.isEmpty)
        
        blogVC!.mappables.append(PostModel())
        
        XCTAssert(blogVC!.mappables.count == 1)
        
        (0..<10).forEach({ _ in blogVC!.mappables.append(PostModel()) })
        
        XCTAssert(blogVC!.mappables.count == 11)
        XCTAssertFalse(blogVC!.mappables.isEmpty)
        
        blogVC!.mappables.removeAll()
        
        XCTAssertTrue(blogVC!.mappables.isEmpty)
    }
    
}

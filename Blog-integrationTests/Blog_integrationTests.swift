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
    
    func testFailableInitializers() {
        
        let blankJSON = [String: Any]()
        let optionalUser01 = ProfileModel(JSON: blankJSON)
        XCTAssertNil(optionalUser01)
        
        let particularJSON = ["id": UUID().uuidString,
                              "nickname": "Testable nickname"]
        let optionalUser02 = ProfileModel(JSON: particularJSON)
        XCTAssertNil(optionalUser02)
        
        let fullJSON = ["id": UUID().uuidString,
                        "nickname": "Testable nickname",
                        "email": "test.email@gmail.com"]
        let optionalUser03 = ProfileModel(JSON: fullJSON)
        XCTAssertNotNil(optionalUser03)
        
        XCTAssertEqual(optionalUser03?.uid, fullJSON["id"])
        XCTAssertEqual(optionalUser03?.email, fullJSON["email"])
        XCTAssertEqual(optionalUser03?.nickname, fullJSON["nickname"])
    }
    
    func testMockTopUsersVC() {
        
        let topUserVC = TopUsersVC()
        
        topUserVC.apiManager = MockAPIManager()
        
        topUserVC.loadDataFromServer(completionHandler: { error in
            
            XCTAssertNil(error)
            
            XCTAssertFalse(topUserVC.mappables.isEmpty)
        })
    }
    
    func testMockAnotherBlogVC() {
        
        let blogVC = AnotherBlogVC()
        
        blogVC.user = ProfileModel(JSON: ["id": UUID().uuidString,
                                            "email": UUID().uuidString,
                                            "nickname": UUID().uuidString])
        
        blogVC.apiManager = MockAPIManager()
        
        blogVC.loadDataFromServer(completionHandler: { error in
            
            XCTAssertNil(error)
            
            XCTAssertFalse(blogVC.mappables.isEmpty)
        })
    }
    
}

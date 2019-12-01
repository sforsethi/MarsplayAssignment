//
//  Marsplay_AssignmentTests.swift
//  Marsplay AssignmentTests
//
//  Created by Raghav Sethi on 02/12/19.
//  Copyright © 2019 Raghav Sethi. All rights reserved.
//

import XCTest

@testable import Marsplay_Assignment

class Marsplay_AssignmentTests: XCTestCase {

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testValidName()    {
        let movie = Movie(title: "", year: "2020", poster: "abc", type: "movie")
        XCTAssertTrue(movie.validMovie())
    }
    
    func testValidYear()    {
        let movie = Movie(title: "Batman", year: "2000", poster: "abc", type: "movie")
        XCTAssertTrue(movie.validYear()
        )
    }

}

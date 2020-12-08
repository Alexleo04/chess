//
//  King_Test.swift
//  Real_ChessTests
//
//  Created by Aleksey Leonov on 04/12/2020.
//
@testable import Real_Chess
import XCTest

class Bishop_Test: XCTestCase {
    var bishop: Bishop!
    override func setUp() {
        super.setUp()
        bishop = Bishop(.white)
    }
    func testCanMoveSuccessfully(){
        XCTAssertTrue(bishop.canMove(from: Point(letter: .a, digit: 1), to: Point(letter: .h, digit: 8)))
        XCTAssertTrue(bishop.canMove(from: Point(letter: .h, digit: 8), to: Point(letter: .a, digit: 1)))
        XCTAssertTrue(bishop.canMove(from: Point(letter: .h, digit: 1), to: Point(letter: .a, digit: 8)))
        XCTAssertTrue(bishop.canMove(from: Point(letter: .a, digit: 8), to: Point(letter: .h, digit: 1)))
        XCTAssertTrue(bishop.canMove(from: Point(letter: .e, digit: 1), to: Point(letter: .h, digit: 4)))
    }
    func testCantMoveSuccessfully(){
        XCTAssertFalse(bishop.canMove(from: Point(letter: .h, digit: 3), to: Point(letter: .a, digit: 1)))
    }
    override func tearDown() {
        super.tearDown()
        bishop = nil
    }
}

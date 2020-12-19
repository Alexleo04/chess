//
//  Queen_Test.swift
//  Real_ChessTests
//
//  Created by Aleksey Leonov on 04/12/2020.
//
@testable import Real_Chess
import XCTest

class Queen_Test: XCTestCase {
    var queen: Queen!
    override func setUp() {
        super.setUp()
        queen = Queen(.white)
    }
    func testCanMoveSuccessfully(){
        XCTAssertTrue(queen.canMove(from: Point(letter: .e, digit: 2), to: Point(letter: .e, digit: 4)))
                XCTAssertTrue(queen.canMove(from: Point(letter: .e, digit: 2), to: Point(letter: .e, digit: 8)))
        XCTAssertTrue(queen.canMove(from: Point(letter: .e, digit: 2), to: Point(letter: .h, digit: 2)))
        XCTAssertTrue(queen.canMove(from: Point(letter: .a, digit: 8), to: Point(letter: .h, digit: 1)))
        XCTAssertTrue(queen.canMove(from: Point(letter: .e, digit: 2), to: Point(letter: .a, digit: 2)))

        XCTAssertTrue(queen.canMove(from: Point(letter: .a, digit: 1), to: Point(letter: .h, digit: 8)))
        XCTAssertTrue(queen.canMove(from: Point(letter: .h, digit: 8), to: Point(letter: .a, digit: 1)))
        XCTAssertTrue(queen.canMove(from: Point(letter: .h, digit: 1), to: Point(letter: .a, digit: 8)))
    }
    func testCantMoveSuccessfully(){
        XCTAssertFalse(queen.canMove(from: Point(letter: .e, digit: 2), to: Point(letter: .a, digit: 1)))
    }
    override func tearDown() {
        super.tearDown()
        queen = nil
    }
}

//
//  King_Test.swift
//  Real_ChessTests
//
//  Created by Aleksey Leonov on 04/12/2020.
//
@testable import Real_Chess
import XCTest

class King_Test: XCTestCase {
    var king: King!
    override func setUp() {
        super.setUp()
        king = King(.white)
    }
    func testCanMoveSuccessfully(){
        XCTAssertTrue(king.canMove(from: Point(letter: .e, digit: 2), to: Point(letter: .e, digit: 3)))
        XCTAssertTrue(king.canMove(from: Point(letter: .e, digit: 2), to: Point(letter: .e, digit: 1)))
        XCTAssertTrue(king.canMove(from: Point(letter: .e, digit: 2), to: Point(letter: .d, digit: 2)))
        XCTAssertTrue(king.canMove(from: Point(letter: .e, digit: 2), to: Point(letter: .f, digit: 2)))
        XCTAssertTrue(king.canMove(from: Point(letter: .e, digit: 2), to: Point(letter: .d, digit: 3)))
        XCTAssertTrue(king.canMove(from: Point(letter: .e, digit: 2), to: Point(letter: .f, digit: 3)))
        XCTAssertTrue(king.canMove(from: Point(letter: .e, digit: 2), to: Point(letter: .d, digit: 1)))
        XCTAssertTrue(king.canMove(from: Point(letter: .e, digit: 2), to: Point(letter: .f, digit: 1)))
    }
    func testCantMoveSuccessfully(){
        XCTAssertFalse(king.canMove(from: Point(letter: .e, digit: 2), to: Point(letter: .e, digit: 4)))
    }
    func testMyPath(){
        XCTAssertEqual(king.myPath(from: Point(letter: .e, digit: 2), to: Point(letter: .e, digit: 3)), [])
    }
    override func tearDown() {
        super.tearDown()
        king = nil
    }
}

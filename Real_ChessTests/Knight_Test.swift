//
//  King_Test.swift
//  Real_ChessTests
//
//  Created by Aleksey Leonov on 04/12/2020.
//
@testable import Real_Chess
import XCTest

class Knight_Test: XCTestCase {
    var knight: Knight!
    override func setUp() {
        super.setUp()
        knight = Knight(.white)
    }
    func testCanMoveSuccessfully(){
        XCTAssertTrue(knight.canMove(from: Point(letter: .e, digit: 2), to: Point(letter: .d, digit: 4)))
        XCTAssertTrue(knight.canMove(from: Point(letter: .f, digit: 2), to: Point(letter: .d, digit: 1)))
        XCTAssertTrue(knight.canMove(from: Point(letter: .e, digit: 5), to: Point(letter: .f, digit: 3)))
        XCTAssertTrue(knight.canMove(from: Point(letter: .b, digit: 5), to: Point(letter: .c, digit: 7)))
    }
    func testCantMoveSuccessfully(){
        XCTAssertFalse(knight.canMove(from: Point(letter: .e, digit: 2), to: Point(letter: .a, digit: 1)))
    }
    func testMyPath(){
        XCTAssertEqual(knight.myPath(from: Point(letter: .e, digit: 2), to: Point(letter: .d, digit: 4)), [])
    }
    override func tearDown() {
        super.tearDown()
        knight = nil
    }
}

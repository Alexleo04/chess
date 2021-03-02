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
    func testMyPath(){
        XCTAssertEqual([
            Point(letter: .d, digit: 4),
            Point(letter: .e, digit: 5),
            Point(letter: .f, digit: 6)
        ], bishop.myPath(from: Point(letter: .c, digit: 3), to: Point(letter: .g, digit: 7)))
        XCTAssertEqual([
            Point(letter: .f, digit: 6),
            Point(letter: .e, digit: 5),
            Point(letter: .d, digit: 4)
        ], bishop.myPath(from: Point(letter: .g, digit: 7), to: Point(letter: .c, digit: 3)))
        XCTAssertEqual([
            Point(letter: .f, digit: 4),
            Point(letter: .e, digit: 5),
            Point(letter: .d, digit: 6)
        ], bishop.myPath(from: Point(letter: .g, digit: 3), to: Point(letter: .c, digit: 7)))
        XCTAssertEqual([
            Point(letter: .d, digit: 6),
            Point(letter: .e, digit: 5),
            Point(letter: .f, digit: 4)
        ], bishop.myPath(from: Point(letter: .c, digit: 7), to: Point(letter: .g, digit: 3)))
        XCTAssertEqual([
            Point(letter: .d, digit: 3),
            Point(letter: .e, digit: 4),
            Point(letter: .f, digit: 5),
            Point(letter: .g, digit: 6)
        ], bishop.myPath(from: Point(letter: .c, digit: 2), to: Point(letter: .h, digit: 7)))
        XCTAssertEqual([
        ], bishop.myPath(from: Point(letter: .a, digit: 1), to: Point(letter: .b, digit: 2)))
    }
    override func tearDown() {
        super.tearDown()
        bishop = nil
    }
}

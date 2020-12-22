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
    func testMyPath(){
        XCTAssertEqual([
            Point(letter: .d, digit: 4),
            Point(letter: .e, digit: 5),
            Point(letter: .f, digit: 6)
        ], queen.myPath(from: Point(letter: .c, digit: 3), to: Point(letter: .g, digit: 7)))
        XCTAssertEqual([
            Point(letter: .f, digit: 6),
            Point(letter: .e, digit: 5),
            Point(letter: .d, digit: 4)
        ], queen.myPath(from: Point(letter: .g, digit: 7), to: Point(letter: .c, digit: 3)))
        XCTAssertEqual([
            Point(letter: .f, digit: 4),
            Point(letter: .e, digit: 5),
            Point(letter: .d, digit: 6)
        ], queen.myPath(from: Point(letter: .g, digit: 3), to: Point(letter: .c, digit: 7)))
        XCTAssertEqual([
            Point(letter: .d, digit: 6),
            Point(letter: .e, digit: 5),
            Point(letter: .f, digit: 4)
        ], queen.myPath(from: Point(letter: .c, digit: 7), to: Point(letter: .g, digit: 3)))
        XCTAssertEqual([
            Point(letter: .d, digit: 3),
            Point(letter: .e, digit: 4),
            Point(letter: .f, digit: 5),
            Point(letter: .g, digit: 6)
        ], queen.myPath(from: Point(letter: .c, digit: 2), to: Point(letter: .h, digit: 7)))
        XCTAssertEqual([
            Point(letter: .a, digit: 2),
            Point(letter: .a, digit: 3),
            Point(letter: .a, digit: 4),
            Point(letter: .a, digit: 5),
            Point(letter: .a, digit: 6)
        ], queen.myPath(from: Point(letter: .a, digit: 1), to: Point(letter: .a, digit: 7)))
        XCTAssertEqual([
            Point(letter: .a, digit: 6),
            Point(letter: .a, digit: 5),
            Point(letter: .a, digit: 4),
            Point(letter: .a, digit: 3),
            Point(letter: .a, digit: 2)
        ], queen.myPath(from: Point(letter: .a, digit: 7), to: Point(letter: .a, digit: 1)))
        XCTAssertEqual([
            Point(letter: .b, digit: 1),
            Point(letter: .c, digit: 1),
            Point(letter: .d, digit: 1),
            Point(letter: .e, digit: 1)
        ], queen.myPath(from: Point(letter: .a, digit: 1), to: Point(letter: .f, digit: 1)))
        XCTAssertEqual([
            Point(letter: .e, digit: 1),
            Point(letter: .d, digit: 1),
            Point(letter: .c, digit: 1),
            Point(letter: .b, digit: 1)
        ], queen.myPath(from: Point(letter: .f, digit: 1), to: Point(letter: .a, digit: 1)))
        XCTAssertEqual([
            Point(letter: .b, digit: 3),
            Point(letter: .b, digit: 4),
            Point(letter: .b, digit: 5)
        ], queen.myPath(from: Point(letter: .b, digit: 2), to: Point(letter: .b, digit: 6)))
    }
    override func tearDown() {
        super.tearDown()
        queen = nil
    }
}

//
//  King_Test.swift
//  Real_ChessTests
//
//  Created by Aleksey Leonov on 04/12/2020.
//
@testable import Real_Chess
import XCTest

class Tower_Test: XCTestCase {
    var tower: Tower!
    override func setUp() {
        super.setUp()
        tower = Tower(.white)
    }
    func testCanMoveSuccessfully(){
        XCTAssertTrue(tower.canMove(from: Point(letter: .e, digit: 2), to: Point(letter: .e, digit: 4)))
        XCTAssertTrue(tower.canMove(from: Point(letter: .e, digit: 2), to: Point(letter: .e, digit: 8)))
        XCTAssertTrue(tower.canMove(from: Point(letter: .e, digit: 2), to: Point(letter: .h, digit: 2)))
        XCTAssertTrue(tower.canMove(from: Point(letter: .e, digit: 2), to: Point(letter: .a, digit: 2)))
    }
    func testCantMoveSuccessfully(){
        XCTAssertFalse(tower.canMove(from: Point(letter: .e, digit: 2), to: Point(letter: .a, digit: 1)))
    }
    func testMyPath(){
        XCTAssertEqual([
            Point(letter: .a, digit: 2),
            Point(letter: .a, digit: 3),
            Point(letter: .a, digit: 4),
            Point(letter: .a, digit: 5),
            Point(letter: .a, digit: 6)
        ], tower.myPath(from: Point(letter: .a, digit: 1), to: Point(letter: .a, digit: 7)))
        XCTAssertEqual([
            Point(letter: .a, digit: 6),
            Point(letter: .a, digit: 5),
            Point(letter: .a, digit: 4),
            Point(letter: .a, digit: 3),
            Point(letter: .a, digit: 2)
        ], tower.myPath(from: Point(letter: .a, digit: 7), to: Point(letter: .a, digit: 1)))
        XCTAssertEqual([
            Point(letter: .b, digit: 1),
            Point(letter: .c, digit: 1),
            Point(letter: .d, digit: 1),
            Point(letter: .e, digit: 1)
        ], tower.myPath(from: Point(letter: .a, digit: 1), to: Point(letter: .f, digit: 1)))
        XCTAssertEqual([
            Point(letter: .e, digit: 1),
            Point(letter: .d, digit: 1),
            Point(letter: .c, digit: 1),
            Point(letter: .b, digit: 1)
        ], tower.myPath(from: Point(letter: .f, digit: 1), to: Point(letter: .a, digit: 1)))
        XCTAssertEqual([
            Point(letter: .b, digit: 3),
            Point(letter: .b, digit: 4),
            Point(letter: .b, digit: 5)
        ], tower.myPath(from: Point(letter: .b, digit: 2), to: Point(letter: .b, digit: 6)))
    }
    override func tearDown() {
        super.tearDown()
        tower = nil
    }
}

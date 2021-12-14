//
//  Pawn_test.swift
//  Real_ChessTests
//
//  Created by Aleksey Leonov on 04/12/2020.
//

@testable import Real_Chess
import XCTest

class PawnWhite_Test: XCTestCase {
    var pawn: Pawn!
    override func setUp() {
        super.setUp()
        pawn = Pawn(.white)
    }
    func testCanMoveSuccessfully(){
        XCTAssertTrue(pawn.canMove(from: Point(letter: .a, digit: 2), to: Point(letter: .a, digit: 3)))
        XCTAssertTrue(pawn.canMove(from: Point(letter: .a, digit: 2), to: Point(letter: .a, digit: 4)))
    }
    func testCantMoveSuccessfully(){
        XCTAssertFalse(pawn.canMove(from: Point(letter: .a, digit: 2), to: Point(letter: .b, digit: 3)))
        XCTAssertFalse(pawn.canMove(from: Point(letter: .a, digit: 2), to: Point(letter: .a, digit: 5)))
        XCTAssertFalse(pawn.canMove(from: Point(letter: .a, digit: 2), to: Point(letter: .b, digit: 4)))
        XCTAssertFalse(pawn.canMove(from: Point(letter: .a, digit: 2), to: Point(letter: .a, digit: 1)))
        XCTAssertFalse(pawn.canMove(from: Point(letter: .a, digit: 7), to: Point(letter: .a, digit: 5)))
        XCTAssertFalse(pawn.canMove(from: Point(letter: .a, digit: 6), to: Point(letter: .a, digit: 5)))
        XCTAssertFalse(pawn.canMove(from: Point(letter: .a, digit: 5), to: Point(letter: .a, digit: 4)))
        XCTAssertFalse(pawn.canMove(from: Point(letter: .a, digit: 4), to: Point(letter: .a, digit: 3)))
    }
    func testCanEatProperly(){
        XCTAssertTrue(pawn.canEat(from: Point(letter: .b, digit: 2), to: Point(letter: .c, digit: 3)))
        XCTAssertTrue(pawn.canEat(from: Point(letter: .b, digit: 2), to: Point(letter: .a, digit: 3)))
    }
    func testCantEatProperly(){
        XCTAssertFalse(pawn.canEat(from: Point(letter: .b, digit: 2), to: Point(letter: .b, digit: 3)))
        XCTAssertFalse(pawn.canEat(from: Point(letter: .b, digit: 2), to: Point(letter: .b, digit: 4)))
        XCTAssertFalse(pawn.canEat(from: Point(letter: .b, digit: 2), to: Point(letter: .b, digit: 3)))
        XCTAssertFalse(pawn.canEat(from: Point(letter: .b, digit: 2), to: Point(letter: .a, digit: 1)))
        XCTAssertFalse(pawn.canEat(from: Point(letter: .b, digit: 2), to: Point(letter: .b, digit: 1)))
        XCTAssertFalse(pawn.canEat(from: Point(letter: .b, digit: 2), to: Point(letter: .c, digit: 1)))
    }
    func testMyPath(){
        XCTAssertEqual(pawn.myPath(from: Point(letter: .e, digit: 2), to: Point(letter: .e, digit: 3)), [])
        XCTAssertEqual(pawn.myPath(from: Point(letter: .c, digit: 2), to: Point(letter: .c, digit: 4)), [Point(letter: .c, digit: 3)])
        XCTAssertEqual(pawn.myPath(from: Point(letter: .f, digit: 2), to: Point(letter: .f, digit: 4)), [Point(letter: .f, digit: 3)])
    }
    func testMyMovementPosibility(){
        XCTAssertEqual([
            Point(letter: .f, digit: 3),
            Point(letter: .e, digit: 3),
            Point(letter: .g, digit: 3),
            Point(letter: .f, digit: 4)
        ], pawn.whereCanImove(Point(letter: .f, digit: 2)))
        XCTAssertEqual([
            Point(letter: .h, digit: 3),
            Point(letter: .g, digit: 3),
            Point(letter: .h, digit: 4)
        ], pawn.whereCanImove(Point(letter: .h, digit: 2)))
        XCTAssertEqual([
            Point(letter: .h, digit: 3),
            Point(letter: .g, digit: 3),
            Point(letter: .h, digit: 4)
        ], pawn.whereCanImove(Point(letter: .h, digit: 2)))
        XCTAssertEqual([
            Point(letter: .e, digit: 5),
            Point(letter: .d, digit: 5),
            Point(letter: .f, digit: 5)
        ], pawn.whereCanImove(Point(letter: .e, digit: 4)))
    }
    override func tearDown() {
        super.tearDown()
        pawn = nil
    }
}

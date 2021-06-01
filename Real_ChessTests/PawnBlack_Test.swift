//
//  Pawn_test.swift
//  Real_ChessTests
//
//  Created by Aleksey Leonov on 04/12/2020.
//

@testable import Real_Chess
import XCTest

class PawnBlack_Test: XCTestCase {
    var pawn: Pawn!
    override func setUp() {
        super.setUp()
        pawn = Pawn(.black)
    }
    func testCanMoveSuccessfully(){
        XCTAssertTrue(pawn.canMove(from: Point(letter: .a, digit: 7), to: Point(letter: .a, digit: 6)))
        XCTAssertTrue(pawn.canMove(from: Point(letter: .a, digit: 7), to: Point(letter: .a, digit: 5)))
        XCTAssertTrue(pawn.canMove(from: Point(letter: .a, digit: 6), to: Point(letter: .a, digit: 5)))
        XCTAssertTrue(pawn.canMove(from: Point(letter: .a, digit: 5), to: Point(letter: .a, digit: 4)))
        
    }
    
    func testMyMovementPosibility(){
        XCTAssertEqual([
            Point(letter: .f, digit: 2),
            Point(letter: .e, digit: 2),
            Point(letter: .g, digit: 2),
        ], pawn.whereCanImove(Point(letter: .f, digit: 3)))
        XCTAssertEqual([
            Point(letter: .e, digit: 6),
            Point(letter: .d, digit: 6),
            Point(letter: .f, digit: 6),
            Point(letter: .e, digit: 5)
        ], pawn.whereCanImove(Point(letter: .e, digit: 7)))
    }
    
    func testCantMoveSuccessfully(){
        XCTAssertFalse(pawn.canMove(from: Point(letter: .a, digit: 2), to: Point(letter: .a, digit: 3)))
        XCTAssertFalse(pawn.canMove(from: Point(letter: .a, digit: 6), to: Point(letter: .a, digit: 7)))
        XCTAssertFalse(pawn.canMove(from: Point(letter: .a, digit: 5), to: Point(letter: .a, digit: 6)))
        XCTAssertFalse(pawn.canMove(from: Point(letter: .a, digit: 4), to: Point(letter: .a, digit: 5)))
        XCTAssertFalse(pawn.canMove(from: Point(letter: .a, digit: 2), to: Point(letter: .b, digit: 3)))
        XCTAssertFalse(pawn.canMove(from: Point(letter: .b, digit: 6), to: Point(letter: .c, digit: 7)))
        XCTAssertFalse(pawn.canMove(from: Point(letter: .a, digit: 5), to: Point(letter: .b, digit: 4)))
        XCTAssertFalse(pawn.canMove(from: Point(letter: .a, digit: 4), to: Point(letter: .b, digit: 3)))
    }
    func testCanEatProperly(){
        XCTAssertTrue(pawn.canEat(from: Point(letter: .g, digit: 7), to: Point(letter: .f, digit: 6)))
        XCTAssertTrue(pawn.canEat(from: Point(letter: .g, digit: 7), to: Point(letter: .h, digit: 6)))
    }
    func testMyPath(){
        XCTAssertEqual(pawn.myPath(from: Point(letter: .e, digit: 2), to: Point(letter: .e, digit: 3)), [])
        XCTAssertEqual(pawn.myPath(from: Point(letter: .c, digit: 2), to: Point(letter: .c, digit: 4)), [Point(letter: .c, digit: 3)])
        XCTAssertEqual(pawn.myPath(from: Point(letter: .f, digit: 2), to: Point(letter: .f, digit: 4)), [Point(letter: .f, digit: 3)])
    }
    override func tearDown() {
        super.tearDown()
        pawn = nil
    }
}

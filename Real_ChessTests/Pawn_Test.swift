//
//  Pawn_test.swift
//  Real_ChessTests
//
//  Created by Aleksey Leonov on 04/12/2020.
//

@testable import Real_Chess
import XCTest

class Pawn_Test: XCTestCase {
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

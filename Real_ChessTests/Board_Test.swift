//
//  Board_Test.swift
//  Real_ChessTests
//
//  Created by Aleksey Leonov on 04/12/2020.
//

@testable import Real_Chess
import XCTest

class Board_Test: XCTestCase {
    var board: Board!
    override func setUp() {
        super.setUp()
        board = Board()
    }
    func test(){
        var fromPoint = Point(letter: .d, digit: 1);
        var toPoint = Point(letter: .d, digit: 8);
        board.placeFigure(pos: fromPoint, fig: Queen(.white))
        XCTAssertTrue(board.canMove(fromPoint, toPoint, false))
    }
    func testSuccessfulCastling(){
        XCTAssertTrue(board.castling(Point(letter: .e, digit: 1), Point(letter: .g, digit: 1)))
        XCTAssertTrue(board.castling(Point(letter: .e, digit: 1), Point(letter: .c, digit: 1)))
        XCTAssertTrue(board.castling(Point(letter: .e, digit: 8), Point(letter: .g, digit: 8)))
        XCTAssertTrue(board.castling(Point(letter: .e, digit: 8), Point(letter: .c, digit: 8)))
    }
    func testUnofficialCastling(){
        XCTAssertFalse(board.castling(Point(letter: .e, digit: 1), Point(letter: .d, digit: 1)))
        XCTAssertFalse(board.castling(Point(letter: .e, digit: 1), Point(letter: .b, digit: 1)))
        XCTAssertFalse(board.castling(Point(letter: .e, digit: 1), Point(letter: .a, digit: 1)))
        XCTAssertFalse(board.castling(Point(letter: .e, digit: 8), Point(letter: .d, digit: 8)))
        XCTAssertFalse(board.castling(Point(letter: .e, digit: 8), Point(letter: .b, digit: 8)))
        XCTAssertFalse(board.castling(Point(letter: .e, digit: 8), Point(letter: .a, digit: 8)))
    }
    override func tearDown() {
        super.tearDown()
        board = nil
    }
}

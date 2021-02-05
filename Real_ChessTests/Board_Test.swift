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
        XCTAssertTrue(board.canMove(fromPoint, toPoint))
    }
    override func tearDown() {
        super.tearDown()
        board = nil
    }
}

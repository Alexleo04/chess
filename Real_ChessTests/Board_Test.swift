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
        var testPoint = Point(letter: .a, digit: 2);
        board.figureSpawner(pos: testPoint, fig: Knight(.black))
        XCTAssertNotNil(board.figureReciever(pos: testPoint), "Expected Figure")
    }
    override func tearDown() {
        super.tearDown()
        board = nil
    }
}

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
    override func tearDown() {
        super.tearDown()
        tower = nil
    }
}

////
////  Board_Test.swift
////  Real_ChessTests
////
////  Created by Aleksey Leonov on 04/12/2020.
////
//
//@testable import Real_Chess
//import XCTest
//
//class Board_Test: XCTestCase {
//    var board: BoardController!
//    override func setUp() {
//        super.setUp()
//        board = BoardController()
//    }
//    func test(){
//        let fromPoint = Point(letter: .d, digit: 1);
//        let toPoint = Point(letter: .d, digit: 8);
//        board.placeFigure(pos: fromPoint, fig: Queen(.white))
//        XCTAssertTrue(board.canMove(fromPoint, toPoint, false))
//    }
//    func testShakhSuccessfully(){
//        //board.clearCell(point: Point) - очистить все клетки
//        board.clearField()
//        //board.placeFigure - поставить две фигуры короля и врага(разные цвета)
//        board.placeFigure(pos: Point(letter: .h, digit: 4), fig: Tower(.white))
//        board.placeFigure(pos: Point(letter: .d, digit: 4), fig: King(.black))
//        XCTAssertTrue(board.shakhDetector(.black))
//
//        //правая горизонталь
//        board.clearField()
//        board.placeFigure(pos: Point(letter: .h, digit: 5), fig: Tower(.white))
//        board.placeFigure(pos: Point(letter: .d, digit: 5), fig: King(.black))
//        XCTAssertTrue(board.shakhDetector(.black))
//
//        //левая горизонталь
//        board.clearField()
//        board.placeFigure(pos: Point(letter: .d, digit: 5), fig: Tower(.white))
//        board.placeFigure(pos: Point(letter: .h, digit: 5), fig: King(.black))
//        XCTAssertTrue(board.shakhDetector(.black))
//
//        //нижняя вертикаль
//        board.clearField()
//        board.placeFigure(pos: Point(letter: .d, digit: 3), fig: Tower(.black))
//        board.placeFigure(pos: Point(letter: .d, digit: 6), fig: King(.white))
//        XCTAssertTrue(board.shakhDetector(.white))
//
//        //верхняя вертикаль
//        board.clearField()
//        board.placeFigure(pos: Point(letter: .d, digit: 6), fig: Tower(.black))
//        board.placeFigure(pos: Point(letter: .d, digit: 3), fig: King(.white))
//        XCTAssertTrue(board.shakhDetector(.white))
//
//        //верхняя-левая диагональ
//        board.clearField()
//        board.placeFigure(pos: Point(letter: .b, digit: 7), fig: Bishop(.white))
//        board.placeFigure(pos: Point(letter: .d, digit: 5), fig: King(.black))
//        XCTAssertTrue(board.shakhDetector(.black))
//
//        //нижняя-левая диагональ
//        board.clearField()
//        board.placeFigure(pos: Point(letter: .a, digit: 2), fig: Bishop(.white))
//        board.placeFigure(pos: Point(letter: .d, digit: 5), fig: King(.black))
//        XCTAssertTrue(board.shakhDetector(.black))
//
//        //верхняя-правая диагональ
//        board.clearField()
//        board.placeFigure(pos: Point(letter: .h, digit: 7), fig: Queen(.black))
//        board.placeFigure(pos: Point(letter: .e, digit: 4), fig: King(.white))
//        XCTAssertTrue(board.shakhDetector(.white))
//
//        //нижняя-правая диагональ
//        board.clearField()
//        board.placeFigure(pos: Point(letter: .g, digit: 1), fig: Queen(.black))
//        board.placeFigure(pos: Point(letter: .e, digit: 3), fig: King(.white))
//        XCTAssertTrue(board.shakhDetector(.white))
//
//        //Конь 1
//        board.clearField()
//        board.placeFigure(pos: Point(letter: .e, digit: 6), fig: Knight(.black))
//        board.placeFigure(pos: Point(letter: .d, digit: 4), fig: King(.white))
//        XCTAssertTrue(board.shakhDetector(.white))
//
//        //Конь 2
//        board.clearField()
//        board.placeFigure(pos: Point(letter: .f, digit: 5), fig: Knight(.black))
//        board.placeFigure(pos: Point(letter: .d, digit: 4), fig: King(.white))
//        XCTAssertTrue(board.shakhDetector(.white))
//
//        //Конь 3
//        board.clearField()
//        board.placeFigure(pos: Point(letter: .f, digit: 3), fig: Knight(.black))
//        board.placeFigure(pos: Point(letter: .d, digit: 4), fig: King(.white))
//        XCTAssertTrue(board.shakhDetector(.white))
//
//        //Конь 4
//        board.clearField()
//        board.placeFigure(pos: Point(letter: .e, digit: 2), fig: Knight(.black))
//        board.placeFigure(pos: Point(letter: .d, digit: 4), fig: King(.white))
//        XCTAssertTrue(board.shakhDetector(.white))
//
//        //Конь 5
//        board.clearField()
//        board.placeFigure(pos: Point(letter: .c, digit: 2), fig: Knight(.black))
//        board.placeFigure(pos: Point(letter: .d, digit: 4), fig: King(.white))
//        XCTAssertTrue(board.shakhDetector(.white))
//
//        //Конь 6
//        board.clearField()
//        board.placeFigure(pos: Point(letter: .b, digit: 3), fig: Knight(.black))
//        board.placeFigure(pos: Point(letter: .d, digit: 4), fig: King(.white))
//        XCTAssertTrue(board.shakhDetector(.white))
//
//        //Конь 7
//        board.clearField()
//        board.placeFigure(pos: Point(letter: .b, digit: 5), fig: Knight(.black))
//        board.placeFigure(pos: Point(letter: .d, digit: 4), fig: King(.white))
//        XCTAssertTrue(board.shakhDetector(.white))
//
//        //Конь 8
//        board.clearField()
//        board.placeFigure(pos: Point(letter: .c, digit: 6), fig: Knight(.black))
//        board.placeFigure(pos: Point(letter: .d, digit: 4), fig: King(.white))
//        XCTAssertTrue(board.shakhDetector(.white))
//    }
//    func testSuccessfulCastling(){
//        XCTAssertTrue(board.castling(Point(letter: .e, digit: 1), Point(letter: .g, digit: 1)))
//        XCTAssertTrue(board.castling(Point(letter: .e, digit: 1), Point(letter: .c, digit: 1)))
//        XCTAssertTrue(board.castling(Point(letter: .e, digit: 8), Point(letter: .g, digit: 8)))
//        XCTAssertTrue(board.castling(Point(letter: .e, digit: 8), Point(letter: .c, digit: 8)))
//    }
//    func testUnofficialCastling(){
//        XCTAssertFalse(board.castling(Point(letter: .e, digit: 1), Point(letter: .d, digit: 1)))
//        XCTAssertFalse(board.castling(Point(letter: .e, digit: 1), Point(letter: .b, digit: 1)))
//        XCTAssertFalse(board.castling(Point(letter: .e, digit: 1), Point(letter: .a, digit: 1)))
//        XCTAssertFalse(board.castling(Point(letter: .e, digit: 8), Point(letter: .d, digit: 8)))
//        XCTAssertFalse(board.castling(Point(letter: .e, digit: 8), Point(letter: .b, digit: 8)))
//        XCTAssertFalse(board.castling(Point(letter: .e, digit: 8), Point(letter: .a, digit: 8)))
//    }
//    override func tearDown() {
//        super.tearDown()
//        board = nil
//    }
//}

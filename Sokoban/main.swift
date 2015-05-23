//
//  main.swift
//  Sokoban
//
//  Created by Viacheslav Shambazov on 22/05/2015.
//  Copyright (c) 2015 Viacheslav Shambazov. All rights reserved.
//

import Foundation

//2Darray for the board
enum cell: Character {
    case empty = " "
    case border = "*"
    case box = "O"
    case man = "X"
}

var rows = 10
var cols = 10
var board = Array<Array<cell>>()
for col in 0..<cols {
    board.append(Array(count: rows, repeatedValue: cell.empty))
}

for col in 0..<cols {board[col][0] = cell.border}
for col in 0..<cols {board[col][rows-1] = cell.border}
for row in 0..<rows {board[0][row] = cell.border}
for row in 0..<rows {board[cols-1][row] = cell.border}


//class Man 
class Man {
//принимает action от input и изменяет значение в board
    var name: String
    var coordX: Int
    var coordY: Int
    
    init(name: String) {
        self.name = name
        coordX = 7
        coordY = 3
        self.move(coordX, col: coordY)
    }
    
    func move (row: Int, col: Int) {
        board[row][col] = cell.man
    }
    
    
    func destination (arrow: String) {
        board[coordX][coordY] = cell.empty
        switch arrow {
        case "a" :
                coordX = coordX - 1
            if      board[coordX][coordY] == cell.empty { board[coordX][coordY] = cell.man}
            else if board[coordX][coordY] == cell.border {
                    coordX = coordX + 1
                    board[coordX][coordY] = cell.man}
            else if board[coordX][coordY] == cell.box && board[coordX - 1][coordY] == cell.empty
                    { board[coordX - 1][coordY] = cell.box
                    board[coordX][coordY] = cell.man}
            else if board[coordX - 1][coordY] == cell.border
                    {coordX = coordX + 1
                    board[coordX][coordY] = cell.man }

        case "d" :
                coordX = coordX + 1
            if      board[coordX][coordY] == cell.empty { board[coordX][coordY] = cell.man}
            else if board[coordX][coordY] == cell.border {
                    coordX = coordX - 1
                    board[coordX][coordY] = cell.man}
            else if board[coordX][coordY] == cell.box && board[coordX + 1][coordY] == cell.empty
                    { board[coordX + 1][coordY] = cell.box
                    board[coordX][coordY] = cell.man}
            else if board[coordX + 1][coordY] == cell.border
                    {coordX = coordX - 1
                    board[coordX][coordY] = cell.man }
        case "w" :
                coordY = coordY - 1
            if      board[coordX][coordY] == cell.empty { board[coordX][coordY] = cell.man}
            else if board[coordX][coordY] == cell.border {
                    coordY = coordY + 1
                    board[coordX][coordY] = cell.man}
            else if board[coordX][coordY] == cell.box && board[coordX][coordY - 1] == cell.empty
                    { board[coordX][coordY - 1] = cell.box
                    board[coordX][coordY] = cell.man}
            else if board[coordX][coordY] == cell.box && board[coordX][coordY - 1] == cell.border
                    {board[coordX][coordY] = cell.box
                    coordX = coordY + 1
                    board[coordX][coordY] = cell.man }
        case "s" :
                coordY = coordY + 1
            if      board[coordX][coordY] == cell.empty { board[coordX][coordY] = cell.man}
            else if board[coordX][coordY] == cell.border {
                    coordY = coordY - 1
                    board[coordX][coordY] = cell.man}
            else if board[coordX][coordY] == cell.box && board[coordX][coordY + 1] == cell.empty
                    { board[coordX][coordY + 1] = cell.box
                    board[coordX][coordY] = cell.man}
            else if board[coordX][coordY] == cell.box && board[coordX][coordY + 1] == cell.border
                    {board[coordX][coordY] = cell.box
                    coordX = coordY - 1
                    board[coordX][coordY] = cell.man }
        default: break
        }
    }
}

//class Box
class Box {
//принимает значение от Man и изменяет значение в board
    var name: String
    var coordX: Int
    var coordY: Int
    
    init(name: String) {
        self.name = name
        coordX = 7
        coordY = 7
        self.move(coordX, col: coordY)
    }
    
    func move (row: Int, col: Int) {
        board[row][col] = cell.box
    }
}


//printing
func printBoard (Array: [[cell]]) {
    for col in 0..<cols {
        for row in 0..<rows {
            print(board[row][col].rawValue)
        }
    println()
    }
}

//Text input
func input() -> String {
    var keyboard = NSFileHandle.fileHandleWithStandardInput()
    var inputData = keyboard.availableData
    var strData = NSString(data: inputData, encoding: NSUTF8StringEncoding)!
    
    return strData.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
}

//Users inputs their turns
func userInput() -> String {
    func gettingInput() -> String{  //getting a value from keyboard
        println("choose (a-s-d-w)?")
        var userTurn : String = input()
        return userTurn
    }
    var userTurn = gettingInput()
    return userTurn
}

//*** GAME ***


var turnX: Int
var turnY: Int
var turn: String

var manA = Man(name: "ManA")
var boxA = Box(name: "BoxA")
for i in 1...50 {
    println(printBoard(board))
    turn = userInput()
    manA.destination(turn)
}

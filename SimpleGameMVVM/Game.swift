//
//  Game.swift
//  SimpleGameMVVM
//
//  Created by Sergey Antoniuk on 3/12/21.
//

import Foundation

//Model
struct Game {
    
    enum Move: String, CaseIterable {
        case rock = "✊", scissors = "✌️", papers = "👋"
        
        static var winningMoves: [Move: Move] {
            [
                .rock: .scissors,
                .papers: .rock,
                .scissors: .rock
            ]
        }
    }
    
    enum Player {
        case one, two
    }
    
    enum Result {
        case win, draw, loss
    }
    
    let allMoves = Move.allCases
    
    var activePlayer = Player.one
    
    // to keep activePlayer always synchronized to current choose by computed property
    var moves: (first: Move?, second: Move?) = (nil, nil){
        didSet {
            activePlayer = (moves.first != nil && activePlayer == .one) ? .two : .one
        }
    }
    
    var isGameOver: Bool {
        moves.first != nil && moves.second != nil
    }
    var winner: Player? = nil
    
    func evaluateResult()->Game.Result?{
        //dont have result:
        guard let firstMove = moves.first, let secondMove = moves.second else{
            return nil
        }
        //Draw case:
        if firstMove == secondMove {
            return .draw
        }
        //Win or lose case:
        if let neededMoveToWin = Move.winningMoves[firstMove], secondMove == neededMoveToWin {
            return .win
        }
        return .loss
    }
    
}

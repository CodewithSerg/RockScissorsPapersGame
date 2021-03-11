//
//  GameViewModel.swift
//  SimpleGameMVVM
//
//  Created by Sergey Antoniuk on 3/12/21.
//

import Foundation

//ViewModel

final class GameViewModel: ObservableObject{
   
    @Published private var model = Game()
    
    func getAllowedMoves (forPlayer player: Game.Player)->[Game.Move]{
        if model.activePlayer == player && !model.isGameOver{
            return model.allMoves
        }
        return []
    }
    
    func getStatusText(forPlayer player: Game.Player)->String{
        if !model.isGameOver{
            return model.activePlayer == player ? "":"..."
        }
        if let result = model.evaluateResult() {
            switch result {
            case .win:
                return player == .one ? "You Won!" : "You Lost!"
            case .loss :
                return player == .one ? "You Lost!" : "You Won!"
            case .draw :
                return "DRAW!"
            }
        }
        return "Undefined state"
    }
    
    func getFinalMove(forPlayer player: Game.Player)->String {
        if model.isGameOver {
            switch player {
            case .one:
                return model.moves.first?.rawValue ?? ""
            case .two:
                return model.moves.second?.rawValue ?? ""
                
            }
        }
        return ""
    }
    
    func isGameOver()-> Bool {
        model.isGameOver
    }
    
    func choose (_ move: Game.Move, forPlayer player: Game.Player) {
        print ("Player\(player) chose \(move.rawValue)")
        if player == .one {
            model.moves.first = move
        } else {
            model.moves.second = move
        }
        
    }
    
    func resetGame(){
        model.activePlayer = .one
        model.moves = (nil, nil)
        model.winner = nil
    }
}


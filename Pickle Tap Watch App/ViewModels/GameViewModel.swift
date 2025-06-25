//
//  GameViewModel.swift
//  Pickle Tap Watch App
//
//  Created by Colten Glover on 6/25/25.
//

import Foundation

class GameViewModel: ObservableObject {
    @Published var game = Game()
        
    public func getUserPoints() -> UInt {
        return game.userPoints
    }
    
    public func getOpponentPoints() -> UInt {
        return game.userPoints
    }
    
    public func addPoint(toUser: Bool) {
        if toUser {
            game.userPoints += 1
        } else {
            game.opponentPoints += 1
        }
    }
    
    public func subtractPoint(toUser: Bool) {
        if toUser {
            if game.userPoints > 0 {
                game.userPoints -= 1
            }
        } else {
            if game.opponentPoints > 0 {
                game.opponentPoints -= 1
            }
        }
    }
    
    public func resetPoints() {
        game.userPoints = 0
        game.opponentPoints = 0
    }
}

//
//  AIPlayer.swift
//  TicTacToe
//
//  Created by Алексей Ревякин on 08.05.2023.
//

import Foundation

class AIPlayer {
    
    private let aiPlayer: String
    private let humPlayer: String
    
    init(aiPlayer: String, humPlayer: String) {
        self.aiPlayer = aiPlayer
        self.humPlayer = humPlayer
    }
    
    private func isWin(grid: [String], player: String) -> Bool{
        if grid[0] == player && grid[1] == player && grid[2] == player {
            return true
        }
        if grid[0] == player && grid[4] == player && grid[8] == player {
            return true
        }
        if grid[0] == player && grid[3] == player && grid[6] == player {
            return true
        }
        if grid[1] == player && grid[4] == player && grid[7] == player {
            return true
        }
        if grid[2] == player && grid[4] == player && grid[6] == player {
            return true
        }
        if grid[2] == player && grid[5] == player && grid[8] == player {
            return true
        }
        if grid[3] == player && grid[4] == player && grid[5] == player {
            return true
        }
        if grid[6] == player && grid[7] == player && grid[8] == player {
            return true
        }
        return false
    }
    
    private func emptyIndices(grid: [String]) -> [Int] {
        var result: [Int] = []
        for index in 0..<grid.count {
            if grid[index] == "." {
                result.append(index)
            }
        }
        return result
    }
    
    private func minimax(grid: [String], player: String) -> [Int:Int]{
        var grid = grid
        let emptyIndeces = emptyIndices(grid: grid)
        
        if isWin(grid: grid, player: aiPlayer) {
            return [0:10]
        } else if isWin(grid: grid, player: humPlayer) {
            return [0:-10]
        } else if emptyIndeces.count == 0 {
            return [0:0]
        }
        
        var moves: [[Int:Int]] = []
        for i in emptyIndeces {
            var move: [Int:Int] = [i:0]
            grid[i] = player
            if player == aiPlayer {
                let result = minimax(grid: grid, player: humPlayer)
                move[i] = result.values.first!
            } else  {
                let result = minimax(grid: grid, player: aiPlayer)
                move[i] = result.values.first!
            }
            grid[i] = "."
            moves.append(move)
        }
        var bestMove = 0
        if player == aiPlayer {
            var bestScore = -1000
            for i in 0..<moves.count {
                if moves[i].values.first! > bestScore {
                    bestScore = moves[i].values.first!
                    bestMove = i
                }
            }
        } else {
            var bestScore = 1000
            for i in 0..<moves.count {
                if moves[i].values.first! < bestScore {
                    bestScore = moves[i].values.first!
                    bestMove = i
                }
            }
        }
        return moves[bestMove]
    }
    
    func easyMove(grid: [String]) -> Int {
        return emptyIndices(grid: grid).randomElement()!
    }
    
    func normalMove(grid: [String]) -> Int{
        var grid = grid
        let empty = emptyIndices(grid: grid)
        var moves: [Int] = []
        for index in empty {
            grid[index] = aiPlayer
            if isWin(grid: grid, player: aiPlayer) {
                return index
            }
            grid[index] = humPlayer
            if isWin(grid: grid, player: humPlayer) {
                moves.append(index)
            }
            grid[index] = "."
        }
        if moves.isEmpty {
            return empty.randomElement()!
        } else {
            return moves.randomElement()!
        }
    }
    
    func impossibleMove(grid: [String], player: String) -> Int{
        return minimax(grid: grid, player: player).keys.first!
    }
}

//
//  CifrasGameState.swift
//  CifrasYLetrasApp
//
//  Estado del juego de Cifras
//

import Foundation

/// Estado de una partida de Cifras
struct CifrasGameState: Codable {
    let difficulty: DifficultyLevel
    let availableNumbers: [Int]
    let targetNumber: Int
    var userExpression: String
    var timeRemaining: Int
    var isComplete: Bool
    var userResult: Int?
    var score: Int
    
    init(difficulty: DifficultyLevel, availableNumbers: [Int], targetNumber: Int) {
        self.difficulty = difficulty
        self.availableNumbers = availableNumbers
        self.targetNumber = targetNumber
        self.userExpression = ""
        self.timeRemaining = difficulty.cifrasTime
        self.isComplete = false
        self.userResult = nil
        self.score = 0
    }
    
    /// Calcula la puntuación basándose en la diferencia con el objetivo
    mutating func calculateScore(result: Int) {
        let difference = abs(targetNumber - result)
        
        if difference == 0 {
            score = 10
        } else if difference <= 5 {
            score = 7
        } else if difference <= 10 {
            score = 5
        } else {
            score = 0
        }
        
        userResult = result
        isComplete = true
    }
}

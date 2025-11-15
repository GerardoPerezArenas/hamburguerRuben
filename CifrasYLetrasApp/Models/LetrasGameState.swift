//
//  LetrasGameState.swift
//  CifrasYLetrasApp
//
//  Estado del juego de Letras
//

import Foundation

/// Estado de una partida de Letras
struct LetrasGameState: Codable {
    let difficulty: DifficultyLevel
    let availableLetters: [String]
    var userWord: String
    var timeRemaining: Int
    var isComplete: Bool
    var isValid: Bool
    var score: Int
    var usedWords: [String]
    
    init(difficulty: DifficultyLevel, availableLetters: [String]) {
        self.difficulty = difficulty
        self.availableLetters = availableLetters
        self.userWord = ""
        self.timeRemaining = difficulty.letrasTime
        self.isComplete = false
        self.isValid = false
        self.score = 0
        self.usedWords = []
    }
    
    /// Calcula la puntuación basándose en la longitud de la palabra
    mutating func calculateScore(word: String, isValid: Bool) {
        self.isValid = isValid
        
        if isValid {
            score = word.count
            if !usedWords.contains(word.uppercased()) {
                usedWords.append(word.uppercased())
            }
        } else {
            score = 0
        }
        
        userWord = word
        isComplete = true
    }
}

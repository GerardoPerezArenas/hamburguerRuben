//
//  UserStats.swift
//  CifrasYLetrasApp
//
//  Estadísticas del usuario
//

import Foundation

/// Estadísticas acumuladas del usuario
struct UserStats: Codable {
    var totalScore: Int
    var bestScore: Int
    var gamesPlayed: Int
    var cifrasGamesPlayed: Int
    var letrasGamesPlayed: Int
    var scoreHistory: [Score]
    
    init() {
        self.totalScore = 0
        self.bestScore = 0
        self.gamesPlayed = 0
        self.cifrasGamesPlayed = 0
        self.letrasGamesPlayed = 0
        self.scoreHistory = []
    }
    
    /// Actualiza las estadísticas con una nueva puntuación
    mutating func addScore(_ score: Score) {
        totalScore += score.points
        gamesPlayed += 1
        
        if score.points > bestScore {
            bestScore = score.points
        }
        
        switch score.gameMode {
        case .cifras:
            cifrasGamesPlayed += 1
        case .letras:
            letrasGamesPlayed += 1
        }
        
        scoreHistory.append(score)
        
        // Mantener solo las últimas 100 puntuaciones
        if scoreHistory.count > 100 {
            scoreHistory = Array(scoreHistory.suffix(100))
        }
    }
}

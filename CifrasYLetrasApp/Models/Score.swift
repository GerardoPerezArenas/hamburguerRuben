//
//  Score.swift
//  CifrasYLetrasApp
//
//  Modelo para puntuación individual
//

import Foundation

/// Registro de puntuación de una partida
struct Score: Codable, Identifiable {
    let id: UUID
    let gameMode: GameMode
    let difficulty: DifficultyLevel
    let points: Int
    let date: Date
    
    init(gameMode: GameMode, difficulty: DifficultyLevel, points: Int) {
        self.id = UUID()
        self.gameMode = gameMode
        self.difficulty = difficulty
        self.points = points
        self.date = Date()
    }
}

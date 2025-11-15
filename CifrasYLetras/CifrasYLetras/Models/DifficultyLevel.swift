//
//  DifficultyLevel.swift
//  CifrasYLetras
//
//  Defines the three difficulty levels for the game
//

import Foundation

/// Represents the difficulty level of the game
enum DifficultyLevel: String, CaseIterable, Identifiable {
    case beginner = "Principiante"
    case intermediate = "Intermedio"
    case professional = "Profesional"
    
    var id: String { self.rawValue }
    
    /// Timer duration in seconds for this difficulty level
    var timerDuration: Int {
        switch self {
        case .beginner:
            return 90
        case .intermediate:
            return 60
        case .professional:
            return 45
        }
    }
    
    /// Description of the difficulty level
    var description: String {
        switch self {
        case .beginner:
            return "Combinaciones fáciles, 90 segundos"
        case .intermediate:
            return "Dificultad moderada, 60 segundos"
        case .professional:
            return "Combinaciones complejas, 45 segundos"
        }
    }
    
    /// Icon for the difficulty level
    var icon: String {
        switch self {
        case .beginner:
            return "🌟"
        case .intermediate:
            return "⭐️"
        case .professional:
            return "💎"
        }
    }
}

//
//  DifficultyLevel.swift
//  CifrasYLetrasApp
//
//  Modelo que define los niveles de dificultad
//

import Foundation

/// Niveles de dificultad del juego
enum DifficultyLevel: String, Codable, CaseIterable {
    case principiante = "Principiante"
    case intermedio = "Intermedio"
    case profesional = "Profesional"
    
    var description: String {
        switch self {
        case .principiante:
            return "Más tiempo, retos sencillos"
        case .intermedio:
            return "Equilibrio entre tiempo y dificultad"
        case .profesional:
            return "Poco tiempo, retos complejos"
        }
    }
    
    /// Duración en segundos para el modo Cifras
    var cifrasTime: Int {
        switch self {
        case .principiante: return 90
        case .intermedio: return 60
        case .profesional: return 45
        }
    }
    
    /// Duración en segundos para el modo Letras
    var letrasTime: Int {
        switch self {
        case .principiante: return 90
        case .intermedio: return 60
        case .profesional: return 45
        }
    }
    
    /// Rango de objetivo para Cifras
    var cifrasTargetRange: ClosedRange<Int> {
        switch self {
        case .principiante: return 100...500
        case .intermedio: return 300...700
        case .profesional: return 100...999
        }
    }
    
    /// Número de letras para el modo Letras
    var lettersCount: Int {
        switch self {
        case .principiante: return 8
        case .intermedio: return 9
        case .profesional: return 9
        }
    }
}

//
//  DifficultyService.swift
//  CifrasYLetrasApp
//
//  Servicio de gestión de configuración de dificultad
//

import Foundation

/// Servicio para gestionar la configuración de dificultad
class DifficultyService {
    
    private let userDefaults = UserDefaults.standard
    private let difficultyKey = "selectedDifficulty"
    
    /// Obtiene el nivel de dificultad seleccionado
    /// - Returns: Nivel de dificultad actual o principiante por defecto
    func getSelectedDifficulty() -> DifficultyLevel {
        guard let rawValue = userDefaults.string(forKey: difficultyKey),
              let difficulty = DifficultyLevel(rawValue: rawValue) else {
            return .principiante
        }
        return difficulty
    }
    
    /// Guarda el nivel de dificultad seleccionado
    /// - Parameter difficulty: Nivel de dificultad a guardar
    func setSelectedDifficulty(_ difficulty: DifficultyLevel) {
        userDefaults.set(difficulty.rawValue, forKey: difficultyKey)
    }
    
    /// Obtiene la configuración de tiempo para un modo y nivel
    /// - Parameters:
    ///   - mode: Modo de juego
    ///   - difficulty: Nivel de dificultad
    /// - Returns: Tiempo en segundos
    func getTimeLimit(for mode: GameMode, difficulty: DifficultyLevel) -> Int {
        switch mode {
        case .cifras:
            return difficulty.cifrasTime
        case .letras:
            return difficulty.letrasTime
        }
    }
}

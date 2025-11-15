//
//  StatsService.swift
//  CifrasYLetrasApp
//
//  Servicio de gestión de estadísticas persistentes
//

import Foundation

/// Servicio para gestionar estadísticas del usuario usando UserDefaults
class StatsService {
    
    private let userDefaults = UserDefaults.standard
    private let statsKey = "userStats"
    
    /// Carga las estadísticas del usuario
    /// - Returns: Estadísticas del usuario o nuevas si no existen
    func loadStats() -> UserStats {
        guard let data = userDefaults.data(forKey: statsKey) else {
            return UserStats()
        }
        
        do {
            let stats = try JSONDecoder().decode(UserStats.self, from: data)
            return stats
        } catch {
            print("Error loading stats: \(error)")
            return UserStats()
        }
    }
    
    /// Guarda las estadísticas del usuario
    /// - Parameter stats: Estadísticas a guardar
    func saveStats(_ stats: UserStats) {
        do {
            let data = try JSONEncoder().encode(stats)
            userDefaults.set(data, forKey: statsKey)
        } catch {
            print("Error saving stats: \(error)")
        }
    }
    
    /// Añade una nueva puntuación a las estadísticas
    /// - Parameter score: Puntuación a añadir
    func addScore(_ score: Score) {
        var stats = loadStats()
        stats.addScore(score)
        saveStats(stats)
    }
    
    /// Resetea todas las estadísticas
    func resetStats() {
        let newStats = UserStats()
        saveStats(newStats)
    }
    
    /// Obtiene el historial de puntuaciones
    /// - Parameter limit: Número máximo de puntuaciones a retornar
    /// - Returns: Array de puntuaciones ordenadas por fecha
    func getScoreHistory(limit: Int = 20) -> [Score] {
        let stats = loadStats()
        return Array(stats.scoreHistory.suffix(limit).reversed())
    }
    
    /// Obtiene la mejor puntuación
    /// - Returns: Mejor puntuación registrada
    func getBestScore() -> Int {
        return loadStats().bestScore
    }
    
    /// Obtiene la puntuación total
    /// - Returns: Suma de todas las puntuaciones
    func getTotalScore() -> Int {
        return loadStats().totalScore
    }
}

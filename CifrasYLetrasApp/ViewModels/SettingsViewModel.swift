//
//  SettingsViewModel.swift
//  CifrasYLetrasApp
//
//  ViewModel para la pantalla de ajustes
//

import Foundation

/// ViewModel para la vista de ajustes
class SettingsViewModel: ObservableObject {
    
    @Published var selectedDifficulty: DifficultyLevel
    @Published var showResetConfirmation = false
    
    private let difficultyService: DifficultyService
    private let statsService: StatsService
    
    init(difficultyService: DifficultyService = DifficultyService(),
         statsService: StatsService = StatsService()) {
        self.difficultyService = difficultyService
        self.statsService = statsService
        self.selectedDifficulty = difficultyService.getSelectedDifficulty()
    }
    
    /// Cambia el nivel de dificultad
    func changeDifficulty(_ difficulty: DifficultyLevel) {
        selectedDifficulty = difficulty
        difficultyService.setSelectedDifficulty(difficulty)
    }
    
    /// Resetea todas las estadísticas
    func resetStats() {
        statsService.resetStats()
    }
    
    /// Muestra la confirmación para resetear estadísticas
    func confirmResetStats() {
        showResetConfirmation = true
    }
}

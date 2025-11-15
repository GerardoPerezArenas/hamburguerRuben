//
//  HomeViewModel.swift
//  CifrasYLetrasApp
//
//  ViewModel para la pantalla de inicio
//

import Foundation
import SwiftUI

/// ViewModel para la vista de inicio
class HomeViewModel: ObservableObject {
    
    @Published var selectedMode: GameMode?
    @Published var selectedDifficulty: DifficultyLevel
    @Published var showModeSelection = false
    @Published var showDifficultySelection = false
    @Published var showGame = false
    @Published var userStats: UserStats
    
    private let difficultyService: DifficultyService
    private let statsService: StatsService
    
    init(difficultyService: DifficultyService = DifficultyService(),
         statsService: StatsService = StatsService()) {
        self.difficultyService = difficultyService
        self.statsService = statsService
        self.selectedDifficulty = difficultyService.getSelectedDifficulty()
        self.userStats = statsService.loadStats()
    }
    
    /// Inicia un juego rápido con la configuración actual
    func startQuickGame() {
        // Si no hay modo seleccionado, mostrar selector
        if selectedMode == nil {
            showModeSelection = true
        } else {
            showGame = true
        }
    }
    
    /// Selecciona un modo de juego
    func selectMode(_ mode: GameMode) {
        selectedMode = mode
        showModeSelection = false
        showGame = true
    }
    
    /// Selecciona un nivel de dificultad
    func selectDifficulty(_ difficulty: DifficultyLevel) {
        selectedDifficulty = difficulty
        difficultyService.setSelectedDifficulty(difficulty)
        showDifficultySelection = false
    }
    
    /// Muestra el selector de modo
    func showModeSelector() {
        showModeSelection = true
    }
    
    /// Muestra el selector de dificultad
    func showDifficultySelector() {
        showDifficultySelection = true
    }
    
    /// Actualiza las estadísticas
    func refreshStats() {
        userStats = statsService.loadStats()
    }
}

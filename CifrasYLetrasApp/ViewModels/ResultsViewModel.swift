//
//  ResultsViewModel.swift
//  CifrasYLetrasApp
//
//  ViewModel para la pantalla de resultados
//

import Foundation

/// ViewModel para la vista de resultados
class ResultsViewModel: ObservableObject {
    
    @Published var gameMode: GameMode
    @Published var score: Int
    @Published var showDetails = false
    
    let cifrasState: CifrasGameState?
    let letrasState: LetrasGameState?
    
    private let statsService: StatsService
    
    init(cifrasState: CifrasGameState? = nil,
         letrasState: LetrasGameState? = nil,
         statsService: StatsService = StatsService()) {
        
        self.cifrasState = cifrasState
        self.letrasState = letrasState
        self.statsService = statsService
        
        if let cifras = cifrasState {
            self.gameMode = .cifras
            self.score = cifras.score
        } else if let letras = letrasState {
            self.gameMode = .letras
            self.score = letras.score
        } else {
            self.gameMode = .cifras
            self.score = 0
        }
    }
    
    /// Obtiene el mensaje de resultado
    func getResultMessage() -> String {
        if score >= 10 {
            return "¡Excelente!"
        } else if score >= 7 {
            return "¡Muy bien!"
        } else if score >= 5 {
            return "¡Bien!"
        } else if score > 0 {
            return "Puedes mejorar"
        } else {
            return "Inténtalo de nuevo"
        }
    }
    
    /// Obtiene las estadísticas totales del usuario
    func getTotalStats() -> UserStats {
        return statsService.loadStats()
    }
}

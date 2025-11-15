//
//  CifrasViewModel.swift
//  CifrasYLetrasApp
//
//  ViewModel para el juego de Cifras
//

import Foundation
import Combine

/// ViewModel para el juego de Cifras
class CifrasViewModel: ObservableObject {
    
    @Published var gameState: CifrasGameState
    @Published var timeRemaining: Int
    @Published var isGameActive = true
    @Published var currentExpression = ""
    @Published var errorMessage: String?
    @Published var showResults = false
    
    private let generator: CifrasGenerator
    private let evaluator: ExpressionEvaluator
    private let statsService: StatsService
    private var timer: Timer?
    
    init(difficulty: DifficultyLevel,
         generator: CifrasGenerator = CifrasGenerator(),
         evaluator: ExpressionEvaluator = ExpressionEvaluator(),
         statsService: StatsService = StatsService()) {
        
        self.generator = generator
        self.evaluator = evaluator
        self.statsService = statsService
        
        let numbers = generator.generateNumbers(for: difficulty)
        let target = generator.generateTarget(for: difficulty)
        
        self.gameState = CifrasGameState(
            difficulty: difficulty,
            availableNumbers: numbers,
            targetNumber: target
        )
        
        self.timeRemaining = difficulty.cifrasTime
        
        startTimer()
    }
    
    /// Inicia el cronómetro
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.endGame()
            }
        }
    }
    
    /// Añade un número a la expresión
    func addNumber(_ number: Int) {
        currentExpression += "\(number)"
    }
    
    /// Añade una operación a la expresión
    func addOperation(_ operation: String) {
        currentExpression += operation
    }
    
    /// Borra el último carácter
    func backspace() {
        if !currentExpression.isEmpty {
            currentExpression.removeLast()
        }
    }
    
    /// Limpia la expresión
    func clear() {
        currentExpression = ""
        errorMessage = nil
    }
    
    /// Valida y evalúa la solución del usuario
    func validateSolution() {
        errorMessage = nil
        
        do {
            // Validar que usa solo números disponibles
            guard evaluator.validate(expression: currentExpression, withNumbers: gameState.availableNumbers) else {
                errorMessage = "Has usado una cifra que no está disponible"
                return
            }
            
            // Evaluar la expresión
            let result = try evaluator.evaluate(currentExpression)
            
            // Calcular puntuación
            gameState.calculateScore(result: result)
            
            // Guardar estadísticas
            let score = Score(
                gameMode: .cifras,
                difficulty: gameState.difficulty,
                points: gameState.score
            )
            statsService.addScore(score)
            
            // Mostrar resultados
            endGame()
            
        } catch {
            errorMessage = "Expresión no válida"
        }
    }
    
    /// Finaliza el juego
    func endGame() {
        timer?.invalidate()
        isGameActive = false
        showResults = true
    }
    
    /// Obtiene sugerencias de soluciones
    func getSuggestions() -> [String] {
        return generator.findApproximateSolutions(
            numbers: gameState.availableNumbers,
            target: gameState.targetNumber
        )
    }
    
    deinit {
        timer?.invalidate()
    }
}

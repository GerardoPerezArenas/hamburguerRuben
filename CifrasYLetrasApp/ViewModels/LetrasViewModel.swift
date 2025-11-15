//
//  LetrasViewModel.swift
//  CifrasYLetrasApp
//
//  ViewModel para el juego de Letras
//

import Foundation
import Combine

/// ViewModel para el juego de Letras
class LetrasViewModel: ObservableObject {
    
    @Published var gameState: LetrasGameState
    @Published var timeRemaining: Int
    @Published var isGameActive = true
    @Published var currentWord = ""
    @Published var errorMessage: String?
    @Published var successMessage: String?
    @Published var showResults = false
    
    private let generator: LetrasGenerator
    private let dictionaryService: DictionaryService
    private let statsService: StatsService
    private var timer: Timer?
    
    init(difficulty: DifficultyLevel,
         generator: LetrasGenerator = LetrasGenerator(),
         dictionaryService: DictionaryService = DictionaryService(),
         statsService: StatsService = StatsService()) {
        
        self.generator = generator
        self.dictionaryService = dictionaryService
        self.statsService = statsService
        
        let letters = generator.generateLetters(for: difficulty)
        
        self.gameState = LetrasGameState(
            difficulty: difficulty,
            availableLetters: letters
        )
        
        self.timeRemaining = difficulty.letrasTime
        
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
    
    /// Añade una letra a la palabra actual
    func addLetter(_ letter: String) {
        currentWord += letter.uppercased()
    }
    
    /// Borra la última letra
    func backspace() {
        if !currentWord.isEmpty {
            currentWord.removeLast()
        }
    }
    
    /// Limpia la palabra actual
    func clear() {
        currentWord = ""
        errorMessage = nil
        successMessage = nil
    }
    
    /// Valida la palabra del usuario
    func validateWord() {
        errorMessage = nil
        successMessage = nil
        
        // Verificar que la palabra no esté vacía
        guard !currentWord.isEmpty else {
            errorMessage = "Introduce una palabra"
            return
        }
        
        // Verificar que se puede formar con las letras disponibles
        guard generator.canFormWord(currentWord, with: gameState.availableLetters) else {
            errorMessage = "No puedes formar esta palabra con las letras disponibles"
            return
        }
        
        // Verificar que la palabra no se haya usado antes
        guard !gameState.usedWords.contains(currentWord.uppercased()) else {
            errorMessage = "Esta palabra ya ha sido usada"
            return
        }
        
        // Validar con el diccionario
        let isValid = dictionaryService.isValidWord(currentWord)
        
        if isValid {
            // Calcular puntuación
            gameState.calculateScore(word: currentWord, isValid: true)
            
            successMessage = "¡Palabra válida! +\(currentWord.count) puntos"
            
            // Limpiar para permitir otra palabra
            currentWord = ""
            
        } else {
            errorMessage = "Palabra no válida"
        }
    }
    
    /// Finaliza el juego y guarda estadísticas
    func endGame() {
        timer?.invalidate()
        isGameActive = false
        
        // Guardar estadísticas
        let score = Score(
            gameMode: .letras,
            difficulty: gameState.difficulty,
            points: gameState.score
        )
        statsService.addScore(score)
        
        showResults = true
    }
    
    /// Obtiene palabras posibles con las letras disponibles
    func getPossibleWords() -> [String] {
        return dictionaryService.findPossibleWords(
            with: gameState.availableLetters,
            minLength: 4
        )
    }
    
    /// Obtiene una pista (solo para nivel principiante)
    func getHint() -> String? {
        guard gameState.difficulty == .principiante else {
            return nil
        }
        
        let possibleWords = getPossibleWords()
        if let longestWord = possibleWords.first {
            return "Hay una palabra de al menos \(longestWord.count) letras"
        }
        
        return nil
    }
    
    deinit {
        timer?.invalidate()
    }
}

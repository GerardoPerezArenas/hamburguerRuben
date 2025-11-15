//
//  NumberGameModel.swift
//  CifrasYLetras
//
//  Model for the Numbers game mode (Cifras)
//

import Foundation

/// Represents the state and data for a number game
class NumberGameModel: ObservableObject {
    @Published var availableNumbers: [Int] = []
    @Published var targetNumber: Int = 0
    @Published var difficulty: DifficultyLevel = .beginner
    @Published var timeRemaining: Int = 0
    @Published var playerSolution: String = ""
    @Published var playerResult: Int? = nil
    @Published var isGameActive: Bool = false
    
    /// Large numbers available for selection (25, 50, 75, 100)
    private let largeNumbers = [25, 50, 75, 100]
    
    /// Small numbers available for selection (1-10, with two of each)
    private let smallNumbers = [1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10]
    
    /// Start a new game with the given difficulty
    func startNewGame(difficulty: DifficultyLevel) {
        self.difficulty = difficulty
        self.timeRemaining = difficulty.timerDuration
        self.playerSolution = ""
        self.playerResult = nil
        self.isGameActive = true
        
        generateNumbers(for: difficulty)
        generateTargetNumber(for: difficulty)
    }
    
    /// Generate random numbers based on difficulty
    private func generateNumbers(for difficulty: DifficultyLevel) {
        var numbers: [Int] = []
        
        // Number of large numbers increases with difficulty
        let largeCount: Int
        switch difficulty {
        case .beginner:
            largeCount = 1
        case .intermediate:
            largeCount = 2
        case .professional:
            largeCount = Int.random(in: 2...3)
        }
        
        // Select random large numbers
        var availableLarge = largeNumbers.shuffled()
        for _ in 0..<largeCount {
            if let number = availableLarge.popLast() {
                numbers.append(number)
            }
        }
        
        // Fill remaining slots with small numbers
        let smallCount = 6 - largeCount
        var availableSmall = smallNumbers.shuffled()
        for _ in 0..<smallCount {
            if let number = availableSmall.popLast() {
                numbers.append(number)
            }
        }
        
        availableNumbers = numbers.shuffled()
    }
    
    /// Generate a target number based on difficulty
    private func generateTargetNumber(for difficulty: DifficultyLevel) {
        switch difficulty {
        case .beginner:
            // Easier targets (100-500)
            targetNumber = Int.random(in: 100...500)
        case .intermediate:
            // Medium targets (200-700)
            targetNumber = Int.random(in: 200...700)
        case .professional:
            // Harder targets (300-999)
            targetNumber = Int.random(in: 300...999)
        }
    }
    
    /// End the current game
    func endGame() {
        isGameActive = false
    }
    
    /// Update the time remaining
    func updateTimer() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            endGame()
        }
    }
}

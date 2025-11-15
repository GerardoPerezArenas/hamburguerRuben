//
//  WordGameModel.swift
//  CifrasYLetras
//
//  Model for the Word game mode (Letras)
//

import Foundation

/// Represents the state and data for a word game
class WordGameModel: ObservableObject {
    @Published var availableLetters: [Character] = []
    @Published var difficulty: DifficultyLevel = .beginner
    @Published var timeRemaining: Int = 0
    @Published var playerWord: String = ""
    @Published var isGameActive: Bool = false
    @Published var isWordValid: Bool? = nil
    
    /// Spanish vowels including special characters
    private let vowels: [Character] = ["A", "E", "I", "O", "U"]
    
    /// Spanish consonants including Ñ
    private let consonants: [Character] = [
        "B", "C", "D", "F", "G", "H", "J", "K", "L", "M",
        "N", "Ñ", "P", "Q", "R", "S", "T", "V", "W", "X", "Y", "Z"
    ]
    
    /// Start a new game with the given difficulty
    func startNewGame(difficulty: DifficultyLevel) {
        self.difficulty = difficulty
        self.timeRemaining = difficulty.timerDuration
        self.playerWord = ""
        self.isWordValid = nil
        self.isGameActive = true
        
        generateLetters(for: difficulty)
    }
    
    /// Generate random letters with balanced vowel/consonant ratio
    private func generateLetters(for difficulty: DifficultyLevel) {
        var letters: [Character] = []
        
        // Always use 9 letters total
        let totalLetters = 9
        
        // Vowel count based on difficulty (harder = fewer vowels)
        let vowelCount: Int
        switch difficulty {
        case .beginner:
            vowelCount = 4 // More vowels for easier word formation
        case .intermediate:
            vowelCount = 3 // Balanced
        case .professional:
            vowelCount = Int.random(in: 2...3) // Fewer vowels, more challenging
        }
        
        // Select random vowels
        for _ in 0..<vowelCount {
            if let vowel = vowels.randomElement() {
                letters.append(vowel)
            }
        }
        
        // Fill remaining with consonants
        let consonantCount = totalLetters - vowelCount
        for _ in 0..<consonantCount {
            if let consonant = consonants.randomElement() {
                letters.append(consonant)
            }
        }
        
        availableLetters = letters.shuffled()
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
    
    /// Check if the player's word uses only available letters
    func canFormWord(_ word: String) -> Bool {
        let upperWord = word.uppercased()
        var lettersUsed = availableLetters
        
        for char in upperWord {
            if let index = lettersUsed.firstIndex(of: char) {
                lettersUsed.remove(at: index)
            } else {
                return false
            }
        }
        
        return true
    }
}
